Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 776A076BF74
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 23:46:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQxAc-0003IB-Ko; Tue, 01 Aug 2023 17:44:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQxAa-0003Hx-3F
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 17:44:44 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQxAY-0001Kt-HB
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 17:44:43 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fe1fc8768aso27715775e9.1
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 14:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690926280; x=1691531080;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Tdgha5Vdrv5U9Dg5jxDa/k3XasJ13AQ5j/vbFr4vd68=;
 b=GyNhWq5Ah9bhaEMvtBWZpBhttyclifPLBd11tg8EGxHlHvwLTI0fofbcO/knIfgrh9
 DnBCifYR43H3iR6Xgb1M7wIfTsLZCbDPhNtrzHEneku6k4PeHFGf7XP59J5Bwp5SpJVY
 VMzpScjUe+f1irZfXpYKmQsMKJJNarB+gRiR5xRGCY2TwQyM1PFMH5uln79PY14t2JkL
 3nBf7AqKdFvKmJ1JzMYJ384wmCP3HVOq/8x5mWAUrajKMcYy3T9zr5dKaq80jKaq3xA8
 Rv8+2lLqg0TH8S/FOe5SgOaZvnHwztoQDrOemPCqY6O3KBG1yk+wucle6Cj/INIwIJg8
 qFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690926280; x=1691531080;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Tdgha5Vdrv5U9Dg5jxDa/k3XasJ13AQ5j/vbFr4vd68=;
 b=bgvKpvGnXTw2xpsqGt2cPxNkNhEGzHd4DFdlIT/LXHXHJG6lqxNJdI02xvSQA4kUSx
 DH8dsQmc6GarFbSOUv1oLefCy2vHoXmNtt5TRFqzg325B12KjfiHU6sLuZGTDEe1GMjZ
 YfKV0uJCZ81B1ZOkj7ymMOBQrWS4LxlLDT9waGtv5UQLLh3SBnfsi5Oaxnd4H+keSUbs
 S501H4Y9+8D8weCrrdBY560g+teQBSeyK2k87B2W38l3Ot7keuYaj65CoBJsnftXdiXo
 wMSAsCrsBSKGoOvFT5QbqwoBxc1igNrNb7pm8+Y11ch+/lnDJe8IxbNJG6WXFIE8AzPJ
 UbsA==
X-Gm-Message-State: ABy/qLaQMyp2qIrEk1CH7F/KpJYz+Od9Z+aNm5iC1Srkax6DnBDEZ3lD
 Lst0GPD096uO2pC5Xdqw6iZ2Uw==
X-Google-Smtp-Source: APBJJlHCvXiDAHhASZZIATfndPGgqkZLiWoU7f1Dhm1KN4F0II09USwJoarpVP1VOtqecw6fMyWyxw==
X-Received: by 2002:a1c:7412:0:b0:3fb:a100:2581 with SMTP id
 p18-20020a1c7412000000b003fba1002581mr3567991wmc.14.1690926280448; 
 Tue, 01 Aug 2023 14:44:40 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.174.59])
 by smtp.gmail.com with ESMTPSA id
 c7-20020a7bc847000000b003fe22da3bc5sm1767wml.42.2023.08.01.14.44.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Aug 2023 14:44:39 -0700 (PDT)
Message-ID: <5bbdea57-16d4-9d84-9add-ecf444ff2698@linaro.org>
Date: Tue, 1 Aug 2023 23:44:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] ui/dbus: fix clang compilation issue
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: thuth@redhat.com, Gerd Hoffmann <kraxel@redhat.com>
References: <20230726151221.515761-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230726151221.515761-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 26/7/23 17:12, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> ../ui/dbus-listener.c:236:9: error: expected expression
>          Error *err = NULL;
> 
> See:
> https://gitlab.com/qemu-project/qemu/-/issues/1782#note_1488517427
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   ui/dbus-listener.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Thanks, queued via misc-fixes.


