Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF26B7AEF31
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 17:08:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql9eh-00055J-A2; Tue, 26 Sep 2023 11:07:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ql9eS-00052n-Sv
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 11:07:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ql9eQ-0003J5-MO
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 11:07:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695740820;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AGGC/yr1j6jkd471M9xu68/ucoHeEPM4lMgDfHHj9pY=;
 b=VJUT/CF5LkAkevVND9TyZfP/f8XFuwTSTBThsYirztgFE1xeKfkKQa4pSBh3ZakR6wtiVy
 Lo3FmFa7mbSjv3tvlMBoV4+gL5mEu+yVPl3AGc8EyKu7Aa+LFG0oe6OY9jFzxHphHGolfs
 Ijvse+wqnhPl8SgHJWVx4EHB1C61wcI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-NmVIRgKqNi2Rsy6oYMdOEA-1; Tue, 26 Sep 2023 11:06:58 -0400
X-MC-Unique: NmVIRgKqNi2Rsy6oYMdOEA-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-774086da4dbso1621978785a.0
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 08:06:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695740818; x=1696345618;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AGGC/yr1j6jkd471M9xu68/ucoHeEPM4lMgDfHHj9pY=;
 b=nXl2lsUe7nEZKD3sL5ifQV7pbcpoKwiK24m0NBJqx12UQsfHqx+S/nsXAYQF7r3X+D
 C5JyiJioGY2ZlOHTRtqkKzD6hIZKn1SR2I5sBfPkDdryUiDLZWxnk/DLhWN/u/BXo0mC
 33MN9lp0nv9gZhqa0Djvrstz6bLWhj8QmxLuN7kX5bAdyeCEEGazOd3gI9HAgkGfCfyM
 i9QWFrMLKMOKUUwzb+Ajt3lxKOGfYSDLXHn58Xe//FJrEvNuN1YeSGuUt5Q+9nBfIehl
 +YghpgarO7o2ttWtURtU5rY8IBR551Az4dI3rxRo3n0yTDlrpM0/VTauJ0kAkErxxgVi
 a2BA==
X-Gm-Message-State: AOJu0YxqwGCtyUOM6J0JP2l96cKQJ/9dRM+8KoTBIM8RuOnnNdccbtN8
 2bY+POqLe2jxkZn0kTdHy5l5HwSJf/DG6StYDwvPBaRWihbrmA1JYxp+9t6uAPwr930V7xbppO1
 qe2t4FwdezeBMHU4=
X-Received: by 2002:a05:620a:2588:b0:770:7643:320c with SMTP id
 x8-20020a05620a258800b007707643320cmr11873028qko.19.1695740817948; 
 Tue, 26 Sep 2023 08:06:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiI/KtQhdjgY9zY/BftOnjYThjLDekr4q62LF6Al1kBiE/JbrfCUyMw0DueJE9GRVNfTUfqw==
X-Received: by 2002:a05:620a:2588:b0:770:7643:320c with SMTP id
 x8-20020a05620a258800b007707643320cmr11873003qko.19.1695740817667; 
 Tue, 26 Sep 2023 08:06:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 cx18-20020a05620a51d200b007742c2ad7dfsm2373486qkb.73.2023.09.26.08.06.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Sep 2023 08:06:55 -0700 (PDT)
Message-ID: <ac328c75-3972-ec50-5771-71c5fd24b2aa@redhat.com>
Date: Tue, 26 Sep 2023 17:06:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/4] hw/intc/arm_gicv3_its: Avoid shadowing variable in
 do_process_its_cmd()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>
References: <20230922152944.3583438-1-peter.maydell@linaro.org>
 <20230922152944.3583438-2-peter.maydell@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20230922152944.3583438-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org



On 9/22/23 17:29, Peter Maydell wrote:
> Avoid shadowing a local variable in do_process_its_cmd():
>
> ../../hw/intc/arm_gicv3_its.c:548:17: warning: declaration of ‘ite’ shadows a previous local [-Wshadow=compatible-local]
>   548 |         ITEntry ite = {};
>       |                 ^~~
> ../../hw/intc/arm_gicv3_its.c:518:13: note: shadowed declaration is here
>   518 |     ITEntry ite;
>       |             ^~~
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/intc/arm_gicv3_its.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hw/intc/arm_gicv3_its.c b/hw/intc/arm_gicv3_its.c
> index 5f552b4d37f..52e9aca9c65 100644
> --- a/hw/intc/arm_gicv3_its.c
> +++ b/hw/intc/arm_gicv3_its.c
> @@ -545,10 +545,10 @@ static ItsCmdResult do_process_its_cmd(GICv3ITSState *s, uint32_t devid,
>      }
>  
>      if (cmdres == CMD_CONTINUE_OK && cmd == DISCARD) {
> -        ITEntry ite = {};
> +        ITEntry i = {};
>          /* remove mapping from interrupt translation table */
> -        ite.valid = false;
> -        return update_ite(s, eventid, &dte, &ite) ? CMD_CONTINUE_OK : CMD_STALL;
> +        i.valid = false;
> +        return update_ite(s, eventid, &dte, &i) ? CMD_CONTINUE_OK : CMD_STALL;
>      }
>      return CMD_CONTINUE_OK;
>  }
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric


