Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7654082688B
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 08:26:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMk0E-00015T-Hn; Mon, 08 Jan 2024 02:24:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rMk0C-000156-Kb
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 02:24:52 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rMk0A-00024b-V0
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 02:24:52 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-28bcc273833so1385320a91.1
 for <qemu-devel@nongnu.org>; Sun, 07 Jan 2024 23:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1704698689; x=1705303489;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v6f7Q+DdgsijtuPqWcgW6WrwKIP/dbty9hWGfsSl3H0=;
 b=Mv2LUGKVFeyRewAcX7fpwCIFjCKJv75P0Op0DSDudu67wu1AOkPAksnn0Kh80A8HUP
 T4LBMH0MzkqDXqys8cVL3UM/k+LjbbW5on2Dc4mv9tgkKH7KXQYnlLU2SFG48SQLOl6+
 3CWNIwHXgXDCOsUPaVJfzRCQZDZ0XZW62PbNO5r8No3EAAQytebCxXr942WZ/PWhCTiB
 DQf1140yUsuv8k66b7NcjcpSG1MgWV99mU/ACeqiz1Yzo3we2HVVsRPDihREMmD+r3z4
 60utVqywPmISwUzavMWEVyWbgoxsW7E/HzuKjqcK+gqNqRjCS38z9ugflZZqhAkTLsMO
 du3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704698689; x=1705303489;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v6f7Q+DdgsijtuPqWcgW6WrwKIP/dbty9hWGfsSl3H0=;
 b=KY63Vy4cL3c/xOUM4LzmO8lQl2XecOa5ah/XnW0sc+S/3erXUgqnr531ChWt7v1bCh
 0rgNpeQyvJx1a5VpYC5NX9P+hZZlY2U2NqvsvFvskNoTLoB/ybd3plpUpBLrNPF8PJNq
 dJD4u/M58yIik8BoAMibM24tUOgh5rZHimGs0Y4youwIpLDEPVjgdirrQm2lyaVx9QzE
 /U1RFSbsacuzxj6aJnguPFifV/GKL3jO/i4UFmrTu3RuJtTPylocc4yiN0YvpRjVh909
 g8+UQLREVypEV8ACJum/mdCyeLA9fW9fKkEkKXSdG+D3FjAX6B1kefP9T6VqMz/jKZPX
 IynA==
X-Gm-Message-State: AOJu0YxgqJoGuFRdClDV36PjpBOm5mrTITh2BHrOdltssspU97V0jilC
 hJ+ETHsZBaCyKLUqPA2rL82QfSlT24qZsQ==
X-Google-Smtp-Source: AGHT+IHToq7z8/oGqdskFid37iUYmPDEdsrfyG/DP3WwoarQCe5DgBdRgReIxSHj9w9XZYcMFeXekw==
X-Received: by 2002:a17:90a:4048:b0:28b:c860:fa59 with SMTP id
 k8-20020a17090a404800b0028bc860fa59mr1402522pjg.61.1704698689161; 
 Sun, 07 Jan 2024 23:24:49 -0800 (PST)
Received: from [157.82.205.105] ([157.82.205.105])
 by smtp.gmail.com with ESMTPSA id
 o17-20020a17090ac09100b0028bdb4cc5basm4679180pjs.0.2024.01.07.23.24.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 07 Jan 2024 23:24:48 -0800 (PST)
Message-ID: <37a58ca7-31e6-4d36-9ff2-16071992f43b@daynix.com>
Date: Mon, 8 Jan 2024 16:24:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg/tci: Fix TCI on hppa host and update TCI test matrix
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Helge Deller <deller@kernel.org>, Laurent Vivier <laurent@vivier.eu>,
 Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
References: <ZZpQZ77s2t81mXIT@p100>
 <4ca9e87d-1123-408c-ad49-71c01e332828@linaro.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <4ca9e87d-1123-408c-ad49-71c01e332828@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::1034;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2024/01/07 19:54, Philippe Mathieu-Daudé wrote:
> Cc'ing Akihiko for commit a1eaa6281f.
> 
> On 7/1/24 08:19, Helge Deller wrote:
>> Update the TCI interpreter test matrix for big-endian hosts with
>> big- (hppa, hppa64) and little-endian (x86,x96-64) targets.
>> I used native ppc64 and hppa hosts for those tests.
>>
>> Starting TCI on a hppa host crashed immediately, because hppa is
>> the only archive left where the stack grows upwards.
>> Write-protecting the stack guard page at the top of the stack
>> fixes the crash.
>>
> 
> Fixes: a1eaa6281f ("util: Delete checks for old host definitions")

The change is intentional. If you need HP-PA host support, please 
explain why you need to run latest QEMU on HP-PA. You may also look at 
commit b1cef6d02f ("Drop remaining bits of ia64 host support"), which is 
mentioned in commit a1eaa6281f ("util: Delete checks for old host 
definitions"), if you are going to restore HP-PA host support.

Regards,
Akihiko Odaki

