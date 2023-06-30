Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1827434AE
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 08:01:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF7Ak-0001rU-4y; Fri, 30 Jun 2023 01:59:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Okcj=CS=kaod.org=clg@ozlabs.org>)
 id 1qF7Af-0001r8-E6; Fri, 30 Jun 2023 01:59:53 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Okcj=CS=kaod.org=clg@ozlabs.org>)
 id 1qF7Ad-0005uq-DB; Fri, 30 Jun 2023 01:59:53 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Qsl5Y25fRz4whk;
 Fri, 30 Jun 2023 15:59:45 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qsl5V3lgvz4wgk;
 Fri, 30 Jun 2023 15:59:42 +1000 (AEST)
Message-ID: <75f44d56-df94-1e0f-3e91-ea5b2d911dcb@kaod.org>
Date: Fri, 30 Jun 2023 07:59:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] ppc: spapr: Fix device tree entries in absence of XIVE
 native mode
Content-Language: en-US
To: Gautam Menghani <gautam@linux.ibm.com>, danielhb413@gmail.com,
 harshpb@linux.ibm.com, david@gibson.dropbear.id.au, groug@kaod.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, fbarrat@linux.ibm.com
References: <20230630053056.14933-1-gautam@linux.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230630053056.14933-1-gautam@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=Okcj=CS=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.093,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 6/30/23 07:30, Gautam Menghani wrote:
> Currently, XIVE native exploitation mode is not supported in nested
> guests. When we boot up a nested guest on PowerNV platform, we observe
> the following entries in the device tree of nested guest:
> 
> ```
> device_type = "power-ivpe";
> compatible = "ibm,power-ivpe";
> ```
> 
> But as per LoPAR section B.5.9[1], these entries should only be present
> when XIVE native exploitation mode is being used. Presently, there is no
> support for nested virtualization in the context of XIVE, and hence, DT
> shouldn't advertise support for XIVE interrupt controller to a nested guest.
> 
> Also, according to the present behaviour, when we boot a nested KVM
> guest, the following QEMU warnings are reported	:
> ```
> Calling ibm,client-architecture-support...qemu-system-ppc64: warning:
> kernel_irqchip allowed but unavailable: IRQ_XIVE capability must be present
> for KVM
> Falling back to kernel-irqchip=off

Yes. A QEMU/KVM principle is to be closest as possible to HW using
emulation if necessary, this to be compatible with a platform which
would have the required HW feature. The reason behind is migration.

This is the case on L1s running on Boston systems which have an
old FW not supporting XIVE migration. pseries machines runs with
and emulated XIVE IC. It allowed to migrate such a guest from a
Boston to a Witherspoon where XIVE HW was supported in guests.
KVM-on-pseries is just another platform where XIVE can not use
the KVM backend and needs to run under partially emulation.

I see no reason to change.

Thanks,

C.

