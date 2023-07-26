Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 885A3763C7C
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 18:29:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOhHP-00039T-5d; Wed, 26 Jul 2023 12:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qOhHN-00038L-Jo
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 12:22:25 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qOhHM-0008D2-2U
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 12:22:25 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1b9c5e07c1bso52813355ad.2
 for <qemu-devel@nongnu.org>; Wed, 26 Jul 2023 09:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690388542; x=1690993342;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EqIENYRbm1i8biB1t2dr1SOuzrfmRiON9nBaYtYqjCc=;
 b=YCoQ+usDZrM0r9vrgcNRs673JGMJ4Xoz0oshGxRhXg03mjn/lGoQC/dQvypPolKLdg
 cvWeKzz+2j5+kmYpsUOdRu1VAEDdu8TRUicTDl9KHNE8SDTlKaROzWAY7e8BCwB87G45
 1YL1qecOh166sv+Wxex8jmj2MsFGUXujFlAQXn7M8I0AjzZFqm6Uz/pHLK2KrprsaiOO
 SHWEcOg3ZkRbaxAVlhf9BZWXXhkxWECRfGw8e67ppt41dYotyb3ftgZVFWMH/dp+P5Ik
 2VP+OGMpnddCnp2vihTt3egje4dWwzDwIhW6sfd5ck6jEknI/MEY96GEXQ9koj0gAhv4
 /e6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690388542; x=1690993342;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EqIENYRbm1i8biB1t2dr1SOuzrfmRiON9nBaYtYqjCc=;
 b=JA280GJdhjjM7Q7BkCO5EsjLjojqRAR50yHBn/3gEgBqaf818I1CJJflfG7cf8hyCl
 /flZYv5d1236Osw/cglrwQ8VPlQLFJCPDjiNKwEV0dNvgDaDz1mGhorCMufpDLpAT/NN
 7kpdkRlyjj7GaKVNkxW475bi9QbIOMMvTAmGm4LFFQOgm4dbsWogxYs7CTMeG9T7ro0r
 7WhDaTbP23hUi91y/rY/CYeBDt9FBle0UzNQY2ezU23HzLQ0zevtIQ2e3xcLJy6LFlMg
 cS9cyUk0PrSym1ZgXc1tt8vgiWtbPdRs3QNK6nrwfbJ7/L+QMtrZq6GCqDthngTJ33ly
 sb8Q==
X-Gm-Message-State: ABy/qLZgBTbHFy/fHKQ6lBKTujKJNm1tFjhWqt4c+sUTDqHqyXW49gHz
 rYMrRMXyENI4przsQhajFiy/8w==
X-Google-Smtp-Source: APBJJlEFwTVKHOMzGSmNLP6gkjywIuaJtkC701CW+OaLZEVGdXhhyblIGwBVvMXFfG2+pz1Dty4Zxg==
X-Received: by 2002:a17:903:2343:b0:1b8:76fc:5bf6 with SMTP id
 c3-20020a170903234300b001b876fc5bf6mr3105413plh.43.1690388542280; 
 Wed, 26 Jul 2023 09:22:22 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:9456:37ab:20dc:17e1?
 ([2602:ae:1598:4c01:9456:37ab:20dc:17e1])
 by smtp.gmail.com with ESMTPSA id
 ji17-20020a170903325100b001a6f7744a27sm13391622plb.87.2023.07.26.09.22.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jul 2023 09:22:21 -0700 (PDT)
Message-ID: <2915d99d-18de-4d02-8efc-0c6bf2091071@linaro.org>
Date: Wed, 26 Jul 2023 09:22:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL 0/2] Misc next patches
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Canokeys.org" <contact@canokeys.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 "Hongren (Zenithal) Zheng" <i@zenithal.me>
References: <20230725162304.156157-1-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230725162304.156157-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 7/25/23 09:23, Daniel P. Berrangé wrote:
> The following changes since commit a279ca4ea07383314b2d2b2f1d550be9482f148e:
> 
>    Merge tag 'pull-target-arm-20230725' ofhttps://git.linaro.org/people/pmaydell/qemu-arm  into staging (2023-07-25 12:44:39 +0100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/berrange/qemu  tags/misc-next-pull-request
> 
> for you to fetch changes up to 095be0910b89b5d156e20641bd65ac6cab3f8305:
> 
>    hw/usb/canokey: change license to GPLv2+ (2023-07-25 17:15:59 +0100)
> 
> ----------------------------------------------------------------
> Miscellaneous fixes
> 
>   * Switch canokey device license from Apache to GPLv2+
>   * Fix uninitialized variable warning in LUKS code

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


