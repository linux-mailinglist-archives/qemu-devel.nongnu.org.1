Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B79F4836237
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 12:42:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRsgs-0002FB-T3; Mon, 22 Jan 2024 06:42:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rRsgg-0002Eh-5B
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 06:41:59 -0500
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rRsge-0004Cy-CE
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 06:41:57 -0500
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-50e7f58c5fbso3554673e87.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 03:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705923714; x=1706528514; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7xI6/By+mMtFp8zHg1014M69oJkkrB72yVFY32UuVvY=;
 b=LljPTXQJ/r3c2dshZTDpiW6RJallk5nhPxckVmrZj3ICX7VRJCf82lHUiuHGBr0Ent
 kTN4OXSiJLOdfM61caysQveWWsnp4XygQvrpngmumJtk2r9Vt1Bmrsaz/6sn7jBLdwHh
 L80IO7+k9Tr28pLWOrkQ+0FUkc6k6CoyYTjkUI/3ItYlH/cy1cMoDR5R9UefUWXm6nYs
 TTujpg8kNnBGVrxYc6JYgJR5dPeN9ANZZtJbkTVVQ/403Nyyi9/EuT7PQoq7XdUVTU9f
 3D9si1O400Ki25FcW07mEHTNjpjMeCLGakqzTvfUQzXJT4YuADu/mH8mAc0slfRVL8a3
 ocoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705923714; x=1706528514;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7xI6/By+mMtFp8zHg1014M69oJkkrB72yVFY32UuVvY=;
 b=JUJga6S3yrQkxffhyPG4g2DFDDzA8Ep3Fhq8L77nywbcxmyY9gUI3xsSJsJAiZL0tC
 hZrZLTsDpDUQGDkCJaEf14+8BtRW3+ebuzloiznktLCkEuDY8s9NM6GK3A1tlkBK1rwc
 fr3RiQzhimP3LRGciaanEG59yHGkMfGu5EWBXcDRxv1I91Ua3a04A6/ZwosgiBS8c48f
 Q+0hePcRAlj2Abib+vwnUHlkUEqVcxu1u1fBuzNzGrmuEl3PNrLLORZrxeDnxzegQq07
 4N/iuxAUUbhTox1BXvx2e0TsCA5JJ0m1PffTu5yW9h2+bsTtRX7TOeK/YlEM5clJI97S
 JYjw==
X-Gm-Message-State: AOJu0YxwNrGRXDr4W5MZhi9z93ci/omLSgUA2h+s7CwFDWWSlxcHaJy1
 80009T6RLMOqO8G/xHH6Q+sUfW+F8QfIUGWgki36u+SQggDxSaqf+Qn6VsHXJ0JaMIEuyKG9vhx
 o+ig=
X-Google-Smtp-Source: AGHT+IHBAUK6S4oCR5EyqT4bJAIosWiy1pPbRjz2PGd/pvz0C7Jz8ydtyUI4OTp0D1YOXYjYscbgvQ==
X-Received: by 2002:a05:6512:692:b0:50e:7f88:9ebe with SMTP id
 t18-20020a056512069200b0050e7f889ebemr2045276lfe.103.1705923713898; 
 Mon, 22 Jan 2024 03:41:53 -0800 (PST)
Received: from [192.168.149.175] ([92.88.171.62])
 by smtp.gmail.com with ESMTPSA id
 vi11-20020a170907d40b00b00a2cd74b743csm12044122ejc.3.2024.01.22.03.41.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jan 2024 03:41:53 -0800 (PST)
Message-ID: <e1cb892d-a0c5-470c-9444-8d7a56756f20@linaro.org>
Date: Mon, 22 Jan 2024 12:41:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] linux-user/elfload: check PR_GET_DUMPABLE before
 creating coredump
Content-Language: en-US
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
 Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
References: <20240120-qemu-user-dumpable-v3-0-6aa410c933f1@t-8ch.de>
 <20240120-qemu-user-dumpable-v3-2-6aa410c933f1@t-8ch.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240120-qemu-user-dumpable-v3-2-6aa410c933f1@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 20/1/24 22:45, Thomas Weißschuh wrote:
> A process can opt-out of coredump creation by calling
> prctl(PR_SET_DUMPABLE, 0).
> linux-user passes this call from the guest through to the
> operating system.
>  From there it can be read back again to avoid creating coredumps from
> qemu-user itself if the guest chose so.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
> ---
>   linux-user/elfload.c | 6 ++++++
>   1 file changed, 6 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


