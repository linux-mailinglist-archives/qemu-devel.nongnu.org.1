Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 321D27C9AE3
	for <lists+qemu-devel@lfdr.de>; Sun, 15 Oct 2023 20:56:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qs6Hb-0002Gk-3M; Sun, 15 Oct 2023 14:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qs6HY-0002GL-Qt
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 14:56:08 -0400
Received: from mail-il1-x12d.google.com ([2607:f8b0:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qs6HV-0003sf-D7
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 14:56:07 -0400
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3574297c79eso15991735ab.1
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 11:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697396164; x=1698000964; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6V3LxZBKlvNQEcFf5+SfBgqrouHkiltoBqhctrBAZzk=;
 b=XaLRmy95QXf2ILQm4/4X8RvJ8tT+ADhbzuqfkQVVw1XGO95dOgE83RTUsafq3p/LSv
 cYbImNHr/qd/AjlN2eS/yZSCcW7tcJckNodWs4ApUqNKSBPPovv7lPz0XfIJ1x7X+cmN
 mSdwxValOYAudzDkojWfE4og1KBUMIIwUIx/RHL+47VhhDue8kMj+v5w0YcNtJ2TQkQI
 Wlpbk9143EWwizhQrTBW61JzozyM1mTMFtA5T52QD2HAwyCIfG/ZqytvLQMds1VmKYzy
 oBUa+oV42eCjZi7qT44t2mhxmKy1aO+mBOTR9El2xo6wMMowGjoQiB4ZKGzFQz4I36VZ
 choQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697396164; x=1698000964;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6V3LxZBKlvNQEcFf5+SfBgqrouHkiltoBqhctrBAZzk=;
 b=Ki11AyFrpqhN2mnY4Uwd0o/0kjBslyWiFck7xNWs3z2DSc4ZwCXY5zYkAn6Kg+QxWz
 HTG8ofcLxvHPmevc6bTTJInZAztkCbYrvjkdFEp+7GGv7Uu9GwwZvMw2+fzkhiK2uUyt
 dq5RSHkpPMDtDHHWs4dBuJGChXYxWjDjTumAF2BW0TbUmX/xL1mIg/qbYJwb9xQjUzhZ
 kIHNn2Llal1aQAMwD3YsQqaSmX7cH+u8Q6WQa2YvIXxMeyHv5SOQq6EwwSXidLdKdCbm
 Ba1MSt2XTkn0T0dOmwYxvMHgqkqeje6/hE1Ti+a5nTgT1rkgVwVNs/6tEIjHVreYyL/r
 DtrQ==
X-Gm-Message-State: AOJu0YyIldX5POwwQP4nxuUDl2XShRcgwU73Z/yFfmyisdW+VB6bIBbx
 6gXqhnsUo6kNwHoBR4raS9i4DA==
X-Google-Smtp-Source: AGHT+IGKlATSZtVPufgkj795XNOnht80mLjxPVqlUsBRaaACwtLdr5ui+lYWBrKnXH0vi+oQi3he4g==
X-Received: by 2002:a05:6e02:180a:b0:357:3d82:2d48 with SMTP id
 a10-20020a056e02180a00b003573d822d48mr19491546ilv.8.1697396163989; 
 Sun, 15 Oct 2023 11:56:03 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 b21-20020a170902d31500b001c72f4334afsm7109299plc.20.2023.10.15.11.56.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Oct 2023 11:56:03 -0700 (PDT)
Message-ID: <4d78fc36-7682-4f5a-b986-056413b59529@linaro.org>
Date: Sun, 15 Oct 2023 11:55:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 09/16] util/log: Add Error argument to
 qemu_str_to_log_mask
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, fei2.wu@intel.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20231003183058.1639121-1-richard.henderson@linaro.org>
 <20231003183058.1639121-10-richard.henderson@linaro.org>
 <87y1gamybk.fsf@pond.sub.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <87y1gamybk.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12d;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 10/10/23 05:55, Markus Armbruster wrote:
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> Do not rely on return value of 0 to indicate error,
>> pass along an Error pointer to be set.
> 
> Not wrong, but goes against error.h's recommendation
> 
>   * - Whenever practical, also return a value that indicates success /
>   *   failure.  This can make the error checking more concise, and can
>   *   avoid useless error object creation and destruction.  Note that
>   *   we still have many functions returning void.  We recommend
>   *   • bool-valued functions return true on success / false on failure,
>   *   • pointer-valued functions return non-null / null pointer, and
>   *   • integer-valued functions return non-negative / negative.
> 
...
> Returning -1 here would stick to error.h's recommendation.

The problem had been that 0 would become a valid result in the next patch.
But using -1 would work, particularly with bit 31 of the log mask as yet unused.


r~


