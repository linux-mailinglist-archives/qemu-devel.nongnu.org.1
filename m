Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E307F19BA
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 18:21:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r57wk-00078x-Vb; Mon, 20 Nov 2023 12:20:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r57wb-00077Y-Jh
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 12:20:22 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r57wX-0004u6-4D
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 12:20:21 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40853c639abso18429955e9.0
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 09:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700500814; x=1701105614; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mVIv7aU6HgSc0oGDYnX/XF6kJGW1ilVSANr7wEYc3ok=;
 b=wxwIKyrF/wa5D9g+FVb4C+r5mBruPuk4YCOrZjNjTuEl1pVlQFI+TBgdXyBN+DHeBv
 UY+AyBTBB/0rQKaz8AvAdVTcAL7iw2TS3wGyNkJN41KComkgg7zRBb0kHYOPi4EgiurK
 t4pq06Bo/KlrsOwaEj8uGy1c/wvnAV/QMr8m4OhNsjVoXx4DvWDP5ONz/mfENHetHMCj
 kl7CE86733SOCXM3bBfP8sR6eBKZ+uj2Bd157McIwvpxmQCZcpCJGOsjk89fRkgIiTj+
 AL+2oESoUZLi/jWp0qLI3OHCCfbksKVRXpnnS2ChOWCa9wDY4S6HPBrFrkbf6gxPY//o
 uqNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700500814; x=1701105614;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mVIv7aU6HgSc0oGDYnX/XF6kJGW1ilVSANr7wEYc3ok=;
 b=BxJ2ToBeUReJR6KSFjbOCk4LrpjvuBSbAT0Cygkgj409adlbgaUt69Hl8dMQTWV6nT
 ktu+79etUMjeKs6BSIUGS97hovOa2Bsh83nP9D2zaKAI5/n6v+nwhQ/fDX2vLafW7+Vj
 0wtOP/p59H053lDU5G+/ouKBypbDgl9+xVesUq2pPDEa7TNDt+n4rRRUEYk587el874a
 O8EVxwRF0876V+MyCaaRJYuMesi3Zfm9nCDec1a6TliwMv6d/EmvL4K4W0OW2Xc/TaUn
 +758e/3dXR3p3B+vF2hFYv+yGj4007BS5WET77iv0AII5eFWmxUSZJVrT4AaXOvtHcpi
 zJKQ==
X-Gm-Message-State: AOJu0Yzg6nsKncNurxz644AXjrxaOddfvwXcmItmTBQ8tovo4AH/6XYy
 KaRDnLQMp5M4RvVPoRwmLxeTOg==
X-Google-Smtp-Source: AGHT+IFg25w6dBe/5a41fVBVOUIE6RkZA4iBuu+rdt7GMIJiwIEhxtV3j0+KiiVhqDgKUYG7IXsjpA==
X-Received: by 2002:a05:600c:4f01:b0:40a:5b3c:403 with SMTP id
 l1-20020a05600c4f0100b0040a5b3c0403mr6475909wmq.14.1700500814202; 
 Mon, 20 Nov 2023 09:20:14 -0800 (PST)
Received: from [192.168.69.100] ([176.176.181.190])
 by smtp.gmail.com with ESMTPSA id
 s11-20020adfe00b000000b0032ddc3b88e9sm11913173wrh.0.2023.11.20.09.20.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Nov 2023 09:20:13 -0800 (PST)
Message-ID: <9d6e92d4-b8e5-4bc2-9723-e80d4bdd004e@linaro.org>
Date: Mon, 20 Nov 2023 18:20:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/14] docs/system: clarify limits of using gdbstub in
 system emulation
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Beraldo Leal <bleal@redhat.com>, qemu-arm@nongnu.org,
 devel@lists.libvirt.org, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Marek Vasut <marex@denx.de>, Thomas Huth <thuth@redhat.com>,
 Chris Wulff <crwulff@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>
References: <20231120150833.2552739-1-alex.bennee@linaro.org>
 <20231120150833.2552739-9-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231120150833.2552739-9-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 20/11/23 16:08, Alex Bennée wrote:
> It seems some users will try and use the gdbstub to debug userspace
> inside a system emulation. While possible clarify the limitations of
> this approach and direct the users to a less head scratching way of
> debugging user-space.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Clarifies: https://gitlab.com/qemu-project/qemu/-/issues/1274
> ---
>   docs/system/gdb.rst | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


