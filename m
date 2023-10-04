Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B06CA7B7D3C
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 12:34:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnzCr-0002mG-L4; Wed, 04 Oct 2023 06:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qnzCp-0002l5-A0
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 06:34:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qnzCn-0003Mp-Ud
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 06:34:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696415653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4aHpYEawiIJvxpSRu9Bk+smVIiQ3cGIC8nOKJW4zKDI=;
 b=L+5CtGK4fVgDB2xarz87EGoLd6Hf1p2Yi7TfVu5HTqYPqdtW2UA+g0IC88psFdO+beLYTw
 F3MBbcZCNNiHNiEsLmgiSzIY3rTftRFI4AJ2LFiycU93VAklKcfgZVoHfqaKbW/eXoIXB/
 hcX9VgAG0j/kZtBA3blwwngjleCB6t0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-103-fwQufnUyMVSuMoLg2y-bfw-1; Wed, 04 Oct 2023 06:34:09 -0400
X-MC-Unique: fwQufnUyMVSuMoLg2y-bfw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1A98C29AA3AD;
 Wed,  4 Oct 2023 10:34:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B42B340C2013;
 Wed,  4 Oct 2023 10:34:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id ABAE421E6904; Wed,  4 Oct 2023 12:34:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org,  armbru@redhat.com,
 richard.henderson@linaro.org,  philmd@redhat.com,
 yangxiaojuan@loongson.cn,  maobibo@loongson.cn
Subject: Re: [PATCH 1/1] target/loongarch: Clean up local variable shadowing
References: <20230926071253.3601021-1-gaosong@loongson.cn>
Date: Wed, 04 Oct 2023 12:34:07 +0200
In-Reply-To: <20230926071253.3601021-1-gaosong@loongson.cn> (Song Gao's
 message of "Tue, 26 Sep 2023 15:12:53 +0800")
Message-ID: <87ediak76o.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Song Gao <gaosong@loongson.cn> writes:

> Fix:
>
>   [1839/2601] Compiling C object libqemu-loongarch64-softmmu.fa.p/hw_loongarch_virt.c.o
>   ../hw/loongarch/virt.c: In function 'loongarch_irq_init':
>   ../hw/loongarch/virt.c:665:14: warning: declaration of 'i' shadows a previous local [-Wshadow=compatible-local]
>        for (int i = 0; i < num; i++) {
>                 ^
>   ../hw/loongarch/virt.c:582:19: note: shadowed declaration is here
>        int cpu, pin, i, start, num;
>
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>  hw/loongarch/virt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index 2629128aed..b0a004f860 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -662,7 +662,7 @@ static void loongarch_irq_init(LoongArchMachineState *lams)
>                              sysbus_mmio_get_region(d, 2));
>  
>      /* Connect pch_pic irqs to extioi */
> -    for (int i = 0; i < num; i++) {
> +    for (i = 0; i < num; i++) {
>          qdev_connect_gpio_out(DEVICE(d), i, qdev_get_gpio_in(extioi, i));
>      }

Reviewed-by: Markus Armbruster <armbru@redhat.com>

and queued.  Thanks!


