Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A30E8309A7
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 16:23:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ7ks-00010j-7b; Wed, 17 Jan 2024 10:23:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=gIDE=I3=kaod.org=clg@ozlabs.org>)
 id 1rQ7kh-0000tA-5S; Wed, 17 Jan 2024 10:22:52 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=gIDE=I3=kaod.org=clg@ozlabs.org>)
 id 1rQ7ke-0007Vw-SF; Wed, 17 Jan 2024 10:22:50 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TFV4L5Q1lz4xTx;
 Thu, 18 Jan 2024 02:22:42 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TFV4H5q9Kz4wdD;
 Thu, 18 Jan 2024 02:22:39 +1100 (AEDT)
Message-ID: <765cf0e7-69a9-4be2-bb15-1c8cb432f60a@kaod.org>
Date: Wed, 17 Jan 2024 16:22:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] docs/about: Deprecate the old "power5+" and
 "power7+" CPU names
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org, Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
References: <20240117141054.73841-1-thuth@redhat.com>
 <20240117141054.73841-3-thuth@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240117141054.73841-3-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=gIDE=I3=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On 1/17/24 15:10, Thomas Huth wrote:
> For consistency we should drop the names with a "+" in it in the
> long run.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
>   docs/about/deprecated.rst | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index b47763330c..251723d264 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -217,6 +217,15 @@ Nios II CPU (since 8.2)
>   The Nios II architecture is orphan. The ``nios2`` guest CPU support is
>   deprecated and will be removed in a future version of QEMU.
>   
> +``power5+`` and ``power7+`` CPU names (since 9.0)
> +'''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +The character "+" in device (and thus also CPU) names is not allowed
> +in the QEMU object model anymore. ``power5+``, ``power5+_v2.1``,
> +``power7+`` and ``power7+_v2.1`` are currently still supported via
> +an alias, but for consistency these will get removed in a future
> +release, too. Use ``power5p_v2.1`` and ``power7p_v2.1`` instead.
> +
>   
>   System emulator machines
>   ------------------------


