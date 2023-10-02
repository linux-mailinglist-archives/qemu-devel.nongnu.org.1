Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 897207B4B89
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 08:36:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnCWx-0000B3-Bk; Mon, 02 Oct 2023 02:35:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnCWu-0000Af-Sw
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 02:35:45 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnCWh-0000gM-Px
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 02:35:44 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40651a72807so38428905e9.1
 for <qemu-devel@nongnu.org>; Sun, 01 Oct 2023 23:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696228530; x=1696833330; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rwe7dSQzmXQg5DvNCHp/pf3IIny+tO7x11UaW8WKFi8=;
 b=ds0heYY7lqsrqjZwf5/8WmDr2Kum4BC5jQYG+pltIGsB0YTE5s9m56vAYHVZs6DlGW
 Ks717himyAPJ2yfWWmoYpXJapBQdAyacS41quDMfHMBJsf2ZLoI9/nf/zeULvTiL7pOh
 urRhYO2nRedfb3HvOH3IbmR8Jkdyemgt53NoIfINua/b+jD5hroSJZAUc3atmIcHG6/f
 qdrkiiTdXiWWsfjOrLJLHEuHRJ3uMQ/n6tmbCf52dRYPz0gdjfAwfg8mr2G1D92f8U/F
 sV5mfG48kzPyN1lqygQ6YdMVQ2L6Idv6Ts8Es/TayuFtayIDRtaxIF/tKw1/f2Y0IsTg
 RbXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696228530; x=1696833330;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rwe7dSQzmXQg5DvNCHp/pf3IIny+tO7x11UaW8WKFi8=;
 b=roY75yJvqiNe05n7qvzkjgRxCoud82KAruxlcelUOSRVCx2+zxpe4+NEPjTf1fFW+F
 r6N5I14OxwOFRoA5fxNFO56NnC3pQpfFmS6HnkNHuhfdefycKskjP5rs8ZI8xsF1uPTB
 7n7YsywBnLFhwoJkyBmvl3B8VFAo5y31BurlsAceZIbLJGrZNKYSQbU903Nk79N5tBke
 bjOeOs3Nv8eVY8r51ePn7Y645RqvKTQs70wsGBWfxUwb/w4PWfhLaMszv0i2/reXnc8k
 ZxhxSpe98E22MGkmzSGSve7Gdag12FcVIMyvmKaRTtRjt4dHARsVN2yQMFcHDc6zlIhH
 LUdA==
X-Gm-Message-State: AOJu0YykRbTpW5kBFeAwRO4J2PwbJCTacTnGRznAf2OSpCvLI7YFCG9n
 KdrBDCoNtl8xFT0f2t8N6S5SnedmEI+Y3Fk1rq0=
X-Google-Smtp-Source: AGHT+IGizixrOVkfp7zLuz9LQwcgJsurqE91qamhC0yJWwS71e+pav7ty5ueN97y2mIK16fIi16V0Q==
X-Received: by 2002:a5d:4cd2:0:b0:323:2f54:b6cb with SMTP id
 c18-20020a5d4cd2000000b003232f54b6cbmr9425819wrt.8.1696228530107; 
 Sun, 01 Oct 2023 23:35:30 -0700 (PDT)
Received: from [192.168.69.115] (sto93-h06-176-172-7-203.dsl.sta.abo.bbox.fr.
 [176.172.7.203]) by smtp.gmail.com with ESMTPSA id
 u21-20020adfa195000000b00323293bd023sm18469333wru.6.2023.10.01.23.35.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Oct 2023 23:35:29 -0700 (PDT)
Message-ID: <9b6e334f-b042-b544-ef18-e6199e1de192@linaro.org>
Date: Mon, 2 Oct 2023 08:35:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/2] elf2dmp: check array bounds in pdb_get_file_size
Content-Language: en-US
To: Viktor Prutyanov <viktor@daynix.com>, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, akihiko.odaki@daynix.com, yan@daynix.com,
 viktor.prutyanov@phystech.edu
References: <20230930235317.11469-1-viktor@daynix.com>
 <20230930235317.11469-3-viktor@daynix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230930235317.11469-3-viktor@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.058,
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

On 1/10/23 01:53, Viktor Prutyanov wrote:
> Index in file_size array must be checked against num_files, because the
> entries we are looking for may be absent in the PDB.
> 
> Fixes: Coverity CID 1521597
> Signed-off-by: Viktor Prutyanov <viktor@daynix.com>
> ---
>   contrib/elf2dmp/pdb.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


