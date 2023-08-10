Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 405C1777ED8
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 19:11:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU9BZ-0005yy-CS; Thu, 10 Aug 2023 13:10:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qU9BU-0005yH-BA
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 13:10:52 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qU9BQ-0006wG-Em
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 13:10:50 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1bbff6b2679so8861695ad.1
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 10:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691687446; x=1692292246;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZxMOPh9dOkuMEVe8qKBEydcF9wbCuV5C9JH1zuchmzs=;
 b=IqZNEa3Gkpr1nrFpwm2GEKfx0VRSl8xTwMSrkhs7sG44XhJVwdgwdgfLqXLgTJoMY2
 5ouLLaoJdvlIR+fEVvttjqw6AQae4EJ6oqEVEt2g6Pb8SWZxqlSS/8vYItz9XRALviGX
 cWbSIfn8SjLYSXsie8MdSDRJMwIQQDcJDImLNrlu0jBB26fSMgbhjGhxJf8urXFWCEa/
 a2tzcBUdp3AOM1j40nbNqniuuXomYqvpAF88XLETIrokhqQbsMa2bSnFxyjVYxAQi+Ch
 wUcFIrqi9CnZHQDjJnc199na9PKvf3Nj+IPgkcsGTSsAI6yu5t85giSYHcILlXHk8XqA
 O5RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691687446; x=1692292246;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZxMOPh9dOkuMEVe8qKBEydcF9wbCuV5C9JH1zuchmzs=;
 b=P0ihSoa/Bk6vOTTg4llovSXZGuaHfe4xF3Q8lkMby9v/0dVclZtwtPBR0aQ72dxOEA
 OBvZyVum0WCPqBiA8Q9VrSfoTpjlP6iF0PhGGzAB/Q9jV8JE/ncHidk9q5mGvJ2ftCuc
 YxeyQH58tEVPGm2Z2c05lHjDURhh7zJTiQ+6/RrCAPACzx8ssOfUTphgEViI5kwvsWuM
 3EOcxlWqV40v42aRN9JddzM8BMoTB9QwN3yNE7bK636feL6goFmPiroqnAgRsZJ0G4j4
 e2SKMxQXxdfq0YFR6HFKzLSEA10Lj0eDz0XhOhkquK/VSo5t0ksD79+jRQUGlCT0j7YP
 mzMQ==
X-Gm-Message-State: AOJu0YyvZJZ2riy+e3wEeh+vDKNDOUZsE6Vt9ssQUMvqsHaYAqyrKTrB
 Er+BEUStZfu3MGwSsi1AZlPA7Q==
X-Google-Smtp-Source: AGHT+IH0pyGQ9d3kYugccm4968ZAj8mKTRtHWsYriwy5ZukitLyant26rTe6yqAk5KrBu6NUbQEBSA==
X-Received: by 2002:a17:903:444:b0:1b7:f546:44d7 with SMTP id
 iw4-20020a170903044400b001b7f54644d7mr2299778plb.17.1691687445770; 
 Thu, 10 Aug 2023 10:10:45 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:9e4d:b830:d4fd:9164?
 ([2602:47:d483:7301:9e4d:b830:d4fd:9164])
 by smtp.gmail.com with ESMTPSA id
 a7-20020a170902ecc700b001aaecc0b6ffsm2017370plh.160.2023.08.10.10.10.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Aug 2023 10:10:45 -0700 (PDT)
Message-ID: <02c799be-e6c7-111b-0211-d45bfc34a4d8@linaro.org>
Date: Thu, 10 Aug 2023 10:10:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 4/8] tests: remove test-gdbstub.py
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Yonggang Luo
 <luoyonggang@gmail.com>, Beraldo Leal <bleal@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
References: <20230810153640.1879717-1-alex.bennee@linaro.org>
 <20230810153640.1879717-5-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230810153640.1879717-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.156,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 8/10/23 08:36, Alex Bennée wrote:
> This isn't directly called by our CI and because it doesn't run via
> our run-test.py script does things slightly differently. Lets remove
> it as we have plenty of working in-tree tests now for various aspects
> of gdbstub.
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   tests/guest-debug/test-gdbstub.py | 177 ------------------------------
>   1 file changed, 177 deletions(-)
>   delete mode 100644 tests/guest-debug/test-gdbstub.py

The first sentence could be clearer.  But as it's unused,

Acked-by: Richard Henderson <richard.henderson@linaro.org>


r~

