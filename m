Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81388777F36
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 19:34:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU9XY-0008IU-95; Thu, 10 Aug 2023 13:33:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qU9XV-0008Gh-UQ
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 13:33:38 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qU9XU-00037Y-EZ
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 13:33:37 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1bd9b4f8e0eso7408655ad.1
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 10:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691688815; x=1692293615;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2JnnLrcqUSR/cO44gL/tnfJEOUA8DNDbgFdFPXVws/A=;
 b=Wf/2SgHl8Dt3WWbbZ3mCqtphG69JUc0lxM+4ajyNW+1zaoTioPuSo/HjzoRAuCWRbC
 ys7FQTrsSywH5o3YtXkYR75E4fT2k2jJC0ZBKfivfJ24WA6LACdOZYVor6vhh855dA/d
 ctux9jkyYFsDq08k0H4t79wn/iiC4W51fh0BtaWQgKwEfmlUvEbnn3ObsOjvJZ125kCs
 X35hrOE4B+6uurxdM7uegYU/eVL9kXbyQBWv0EXw1BFviZxKR2Vsth16jcG8pSXt+9AD
 KzC3A9BAsJokbUIW7aM0irN92vYLWvmiqaSOQIU8oLcobGx2AP9gLYnyZ/aWmtPNg5xG
 KziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691688815; x=1692293615;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2JnnLrcqUSR/cO44gL/tnfJEOUA8DNDbgFdFPXVws/A=;
 b=EOi/ibWZ8ORlaa4szZ/k1qyPXVlJPjhLI6uLKZKJX4VX+9UEdcu1kqEIo3Z4XpPbVV
 h8Sn0kXOVTOQfB+t5I7cKuQaVnf/CamqRaCPw3aQitzkkQRpU6rwj/kwEncrFQheb2ng
 p95oLAxTyVjtxGrdYhxC6fQqLih76//NYNP4c7n9qyxxvq+zQFQYwGqdJRVu0FbBIPmD
 WG8rR/u26sscvF5EzW602HL0HrySc2EaO/envgXW3sC0nH679g7qOdw34BX5JC4eBib1
 PlFUC2cyIFlKvp1I3MNQgOqbA7xutDgMnoRi13s03RAoPTkjlDg+UZpxKY4seHrh1QCQ
 FbIg==
X-Gm-Message-State: AOJu0YziN0fImy5+GTNOPFcZTg0Cxhj0Aq3DaAqAXzdlNY14Y7pFONzo
 Zztmn4pZvYQRcWhAMKV4nkKN7Q==
X-Google-Smtp-Source: AGHT+IE20S2Fu48Rsp1XvuJyFTL2uDROvOry2JFMln4B2jgSUVDitPrW5/5nA5dkAULl87bQrxVjVA==
X-Received: by 2002:a17:902:a9c1:b0:1bb:1523:b311 with SMTP id
 b1-20020a170902a9c100b001bb1523b311mr2363701plr.41.1691688814878; 
 Thu, 10 Aug 2023 10:33:34 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:9e4d:b830:d4fd:9164?
 ([2602:47:d483:7301:9e4d:b830:d4fd:9164])
 by smtp.gmail.com with ESMTPSA id
 jc3-20020a17090325c300b001b86492d724sm2052124plb.223.2023.08.10.10.33.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Aug 2023 10:33:34 -0700 (PDT)
Message-ID: <e7b03309-aa23-9144-eb01-a117a2d71dde@linaro.org>
Date: Thu, 10 Aug 2023 10:33:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/8] some testing and gdbstub fixes
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
References: <20230810153640.1879717-1-alex.bennee@linaro.org>
 <CAFEAcA9bOS7tJDe_TRKOUGFcCDq_CjUfzAF7dYYRJbZA=5hvqw@mail.gmail.com>
 <87il9m3ld7.fsf@linaro.org> <3fb6e5ac-5887-2947-b431-4a15394c347b@linaro.org>
In-Reply-To: <3fb6e5ac-5887-2947-b431-4a15394c347b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.156,
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

On 8/10/23 09:43, Richard Henderson wrote:
> On 8/10/23 09:35, Alex Bennée wrote:
>> So 7 and 8? I would argue for 6 as well given that's a foot gun just
>> waiting to happen.
> 
> Yes, the timing issues with 6 are nasty.

I'm going to queue 6-8 to tcg-next, along with the %x change Phil suggested for logging 
non-ASCII characters.


r~


