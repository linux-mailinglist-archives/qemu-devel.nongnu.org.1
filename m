Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BC8788093
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 09:05:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZQrg-0008BK-Pu; Fri, 25 Aug 2023 03:04:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1qZQrX-00089A-8R
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 03:04:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1qZQrU-0000GW-S6
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 03:04:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692947042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+u2a02W8/5bVMdqF3qJ1d3UfSgOkJ7WJ8oFN0Oxnotg=;
 b=Z5Clte467sXhWHrW08qgLKtHCT0Wa/XD48owqlASKGOxrTgNZyJL/4Xzzf1gfQa44f1Glx
 j15bf24f4e4tnesrTpjJKPGafJXawcPMLJUgYqSOghk/6d3v140luOnfYqE4TH1ahREJAA
 +gQyraeYzgr3dE2VSjuyvjoyBskvUAk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-RTzHfmjdPlWc9AYH9PYqew-1; Fri, 25 Aug 2023 03:02:33 -0400
X-MC-Unique: RTzHfmjdPlWc9AYH9PYqew-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4120af3b5b8so6417161cf.0
 for <qemu-devel@nongnu.org>; Fri, 25 Aug 2023 00:02:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692946952; x=1693551752;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+u2a02W8/5bVMdqF3qJ1d3UfSgOkJ7WJ8oFN0Oxnotg=;
 b=YYleTORUopMv71RREOhvk6uCKmVpyTAbFe/yhl+rMGet7V1BtDTsQV6uDgjKKuo3Cf
 Hd6EZ+T9HMs4Wr1jM+swU5aQ6pqWM2MdIQdpstxAfemISdC+GEDUHO00/zs40OgMLaMu
 2N+b7OVrJnbBp/4bpwcU0fPcLw3KhX5IRF3n5IlYgbOgJEkDi/Z+k5N+ZkxOBeRCE5IC
 0CK1PTVvJdHBzFvpYxgxZ4Lbhk30xhrv2yG12NUHrFvGvrbvEhUxNW5lkdhD5JhPtR1r
 PfRE/+zh9jAw2lJWPpBYhkKRmg0OHmjSCZx+TLcVePfm1cvoIKjQK9MLao8QRmneDCHx
 Aj0A==
X-Gm-Message-State: AOJu0Yzg10cFdc0jF93LmNQZO8WISLnj9q3x438tVNr78modqO36oLBt
 rrbdUPn+iT8skISThbA3pKydEMvSy9K6raGCl4QE8AMtH0a9wxHhO6QNtJAFmvcyHDAG2a7XxvF
 tppDtVYBPAaIpA/k=
X-Received: by 2002:a05:622a:44:b0:402:3dbf:85fb with SMTP id
 y4-20020a05622a004400b004023dbf85fbmr23705131qtw.33.1692946952615; 
 Fri, 25 Aug 2023 00:02:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnjZARGP0Tieu7/UsLwHvG29rZFp++VQIb0xHnhyaAvbUtfbiNoFC9ZplHxjdj+bMJaWXU/g==
X-Received: by 2002:a05:622a:44:b0:402:3dbf:85fb with SMTP id
 y4-20020a05622a004400b004023dbf85fbmr23705115qtw.33.1692946952339; 
 Fri, 25 Aug 2023 00:02:32 -0700 (PDT)
Received: from [192.168.100.28] ([82.142.8.70])
 by smtp.gmail.com with ESMTPSA id
 hz9-20020a05622a678900b0040fd47985e6sm340694qtb.97.2023.08.25.00.02.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Aug 2023 00:02:31 -0700 (PDT)
Message-ID: <72f2683a-0a98-d04f-f704-dccf248790b0@redhat.com>
Date: Fri, 25 Aug 2023 09:02:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] tests/qtest/netdev-socket: Avoid variable-length array in
 inet_get_free_port_multiple()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>
References: <20230824164535.2652070-1-peter.maydell@linaro.org>
From: Laurent Vivier <lvivier@redhat.com>
In-Reply-To: <20230824164535.2652070-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.919, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/24/23 18:45, Peter Maydell wrote:
> We use a variable-length array in inet_get_free_port_multiple().
> This is only test code called at the start of a test, so switch to a
> heap allocation instead.
> 
> The codebase has very few VLAs, and if we can get rid of them all we
> can make the compiler error on new additions.  This is a defensive
> measure against security bugs where an on-stack dynamic allocation
> isn't correctly size-checked (e.g.  CVE-2021-3527).
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   tests/qtest/netdev-socket.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/netdev-socket.c b/tests/qtest/netdev-socket.c
> index 097abc0230b..8eed54801f2 100644
> --- a/tests/qtest/netdev-socket.c
> +++ b/tests/qtest/netdev-socket.c
> @@ -82,7 +82,7 @@ static int inet_get_free_port_socket_ipv6(int sock)
>   
>   static int inet_get_free_port_multiple(int nb, int *port, bool ipv6)
>   {
> -    int sock[nb];
> +    g_autofree int *sock = g_new(int, nb);
>       int i;
>   
>       for (i = 0; i < nb; i++) {

Reviewed-by: Laurent Vivier <lvivier@redhat.com>


