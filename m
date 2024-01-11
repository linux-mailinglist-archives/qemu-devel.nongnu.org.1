Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F8282B700
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 23:13:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rO3Hw-0007Rn-Oh; Thu, 11 Jan 2024 17:12:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rO3Ht-0007Rf-6O
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 17:12:33 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rO3Hq-00005K-Dh
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 17:12:32 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1d480c6342dso45571865ad.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 14:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705011149; x=1705615949; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2QscT6yvNfXUt3CgF6rm/JSFamJZLv0/rWveInPuA50=;
 b=ryaJnN6l347TUBqxfW6sJM6U+muSLtpiUjgI9fBVAAA3RWACa+um5QgwYHqYeks3uG
 f00Sp1mM7Ep/8fhNXmZizKi57pF0q5c4OBKgO2Jgm49aUwdQOAhV1/5e/J7LqstMk5UX
 XrT3i3+rvuocJtS3c8nPVbLyeO1sbaooFrYQ/oXdHUMEJfGby0F6K1cOnM+I715krVdY
 6FEOdmsKIvRutJbHDGYBmEpGY2zyqvxBm0V9YAhYnLFU/VaCWGvz/0BTWRqzAhjh7FfA
 SpEUnCRdiNDKbDtqJCF5Sp4tn60oKfORoFdBWr35AWt55ua+GqCiBzpcSeuKyrIXoXHn
 m4Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705011149; x=1705615949;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2QscT6yvNfXUt3CgF6rm/JSFamJZLv0/rWveInPuA50=;
 b=CU4JYscU+Q4vj5HEYR1pIcHbP3WnDGzKFDrknGCaXJglZiZvU45tSFxGrH8eHEfELY
 B+RUEVNgYfTTvm8rokBTSRMX3nc4zEivUyZMsbaGisJNzCy3KBhYGrlZy3pjWUDMpEEf
 BpqI0xQpcFcyqHjT6LkfVeVUnG4JoM3eTc6hPPEh0tuXo5zlsplODDLs5Gon3glSw8is
 hvnLeQk42x88X7l1Gyy5s4g3sTgMkXRLbLZutYk+SajzpyZaU/GPJkUK2AYpZcAPK1bq
 ZCC1BlsuQiq/q3XsM+sqBfG5ZCEla7a91fuoehjltzpAr/MFnSa4fzTgE91YM9I0UeAg
 Hq6A==
X-Gm-Message-State: AOJu0YxTBGBkXiHoskShamRTCvSWVRkPdvmy3HEmGDIPILK0fkT8D2Ss
 MeadS2/n2wGrKV703Hue0F1HKkpA5CMYfw==
X-Google-Smtp-Source: AGHT+IGbJ7dH24DI+Wy8YpDFPCV8XX825J9n/0/bECcQapJ4tF+HZNDt03dj5tbKyvylocYBRek3pw==
X-Received: by 2002:a17:902:7808:b0:1d4:be53:ac54 with SMTP id
 p8-20020a170902780800b001d4be53ac54mr358190pll.79.1705011148880; 
 Thu, 11 Jan 2024 14:12:28 -0800 (PST)
Received: from [192.168.5.64] (ericne.lnk.telstra.net. [203.45.18.161])
 by smtp.gmail.com with ESMTPSA id
 q3-20020a170902dac300b001d49a08495esm1632482plx.118.2024.01.11.14.12.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jan 2024 14:12:28 -0800 (PST)
Message-ID: <66a9fed4-14cc-4e97-8163-18b1cd4f4147@linaro.org>
Date: Fri, 12 Jan 2024 09:12:24 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/12] tests/plugin/mem: fix race condition with callbacks
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>
References: <20240111142326.1743444-1-pierrick.bouvier@linaro.org>
 <20240111142326.1743444-6-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240111142326.1743444-6-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 1/12/24 01:23, Pierrick Bouvier wrote:
> Introduce a lock so global count is correct.
> This was found by comparing with new inline per_vcpu inline op.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   tests/plugin/mem.c | 3 +++
>   1 file changed, 3 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

