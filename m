Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
Delivered-To: lists+qemu-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sM/PN57Eb2lsMQAAu9opvQ
	(envelope-from <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>)
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jan 2026 19:08:30 +0100
X-Original-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EFB491F6
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jan 2026 19:08:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viAAh-0003bb-3O; Tue, 20 Jan 2026 06:45:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1viAAW-0003Tf-2k; Tue, 20 Jan 2026 06:45:10 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1viAAT-00011E-8i; Tue, 20 Jan 2026 06:45:07 -0500
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dwQTd6Yk2zHnGdS;
 Tue, 20 Jan 2026 19:44:21 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id 944AB40572;
 Tue, 20 Jan 2026 19:44:53 +0800 (CST)
Received: from localhost (10.203.177.99) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 20 Jan
 2026 11:44:52 +0000
Date: Tue, 20 Jan 2026 11:44:47 +0000
To: Cornelia Huck <cohuck@redhat.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, Peter Maydell
 <peter.maydell@linaro.org>, Eric Auger <eric.auger@redhat.com>,
 <jonathan.cameron@huawei.com>
Subject: Re: [PATCH RFC 0/3] arm: demuxed ID registers (CCSIDR_EL1)
Message-ID: <20260120114447.00004699.alireza.sanaee@huawei.com>
In-Reply-To: <20260119172732.140613-1-cohuck@redhat.com>
References: <20260119172732.140613-1-cohuck@redhat.com>
Organization: Huawei
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.99]
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=alireza.sanaee@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Alireza Sanaee <alireza.sanaee@huawei.com>
From:  Alireza Sanaee via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
X-Spamd-Result: default: False [-1.01 / 15.00];
	DMARC_POLICY_ALLOW(-0.50)[nongnu.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.51.188.0/24:c];
	MAILLIST(-0.20)[mailman];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[lists,qemu-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	HAS_REPLYTO(0.00)[alireza.sanaee@huawei.com];
	FROM_NEQ_ENVFROM(0.00)[qemu-devel@nongnu.org,qemu-devel-bounces@nongnu.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	HAS_XOIP(0.00)[];
	ASN(0.00)[asn:22989, ipnet:209.51.188.0/24, country:US];
	TAGGED_RCPT(0.00)[qemu-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,huawei.com:replyto,huawei.com:mid,lists.gnu.org:rdns,lists.gnu.org:helo,h.inc:url]
X-Rspamd-Queue-Id: 76EFB491F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 19 Jan 2026 18:27:29 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

Hi Cornelia,



> Note: this is on top of <20260105154119.59853-1-cohuck@redhat.com>
> ("[PATCH v3 0/2] arm: move DCZID_EL0 to idregs array")
> 
> While trying to move to an autogenerated cpu-sysregs.h.inc (so that we
> may keep a common view on registers), we should first address the ID
> registers that are still kept outside of ARMISARegisters. Other than
> DCZID_EL0 (addressed by the series this one goes on top of), that's
> the CCSIDR_EL1 values kept in cpu->cssidr[] (indexed via CSSELR_EL1.)
> 
> My idea was to provide {GET,SET}_IDREG_DEMUX helper that work similar
> to {GET,SET}_IDREG and operate on a two-dimensional array. As a side
> effect, this also allows to get the values KVM provides for CCSIDR_EL1
> (which are virtualized as well.)
> 
> RFC because there are still some open questions:
> - The demux array cannot easily be autogenerated. We can get rid of the
>   ccsidr[] array, but we now have an autogenerated entry in the non-demux
>   array that does nothing. Both are not that nice.
> - I'm not sure if we need any compat handling for KVM (on TCG, everything
>   should stay the same.) In theory, the KVM interface allows setting
>   values from userspace (I didn't try.)
> - There's a slight disagreement between the current code (providing 16
>   entries for CCSIDR_EL1) and the KVM code (providing (7 cache levels) *
>   (data/unified, instruction) = 14 entries.) With FEAT_MTE2, we might be
>   needing 7 more entries.
> 
> Feedback appreciated.
> 
> Cornelia Huck (3):
>   arm: handle demuxed ID registers
>   arm: handle CCSIDR_EL1 as a demuxed register
>   arm/kvm: get demuxed ID registers from kvm
> 
>  hw/intc/armv7m_nvic.c        |  2 +-
>  target/arm/cpu-sysregs.h     |  6 ++++
>  target/arm/cpu-sysregs.h.inc |  1 +
>  target/arm/cpu.h             | 26 ++++++++++++----
>  target/arm/cpu64.c           | 12 ++++----
>  target/arm/helper.c          |  2 +-
>  target/arm/kvm.c             | 33 ++++++++++++++++++++
>  target/arm/tcg/cpu32.c       | 32 +++++++++----------
>  target/arm/tcg/cpu64.c       | 60 ++++++++++++++++++------------------
>  9 files changed, 114 insertions(+), 60 deletions(-)
> 

This impacts my set https://lore.kernel.org/all/20260106155828.643-1-alireza.sanaee@huawei.com/

I tested it with mine of course it required a few changes, but looks like working on TCG, didn't try KVM.

Tested-by: Alireza Sanaee <alireza.sanaee@huawei.com>

