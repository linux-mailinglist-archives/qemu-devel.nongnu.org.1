Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 179E370E097
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 17:33:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Tzn-0007bb-PC; Tue, 23 May 2023 11:32:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1TzQ-0007YU-Uh
 for qemu-devel@nongnu.org; Tue, 23 May 2023 11:31:57 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1TzP-0002P0-B8
 for qemu-devel@nongnu.org; Tue, 23 May 2023 11:31:56 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-64d41763796so3000688b3a.2
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 08:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684855913; x=1687447913;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1+gXJ86s0iju1Tv+h9rhT2Zv/H7OCxTcxpLdnvZGHmE=;
 b=v1zphuEDbD0gDZEk83V2hkkDo93rsJp3vMU4dnESH6iVdGDNl9mRClfKKkfpeTXDZA
 drICepfg7obhKuzr//CrQTNpviQWOuBqrtQfKuvVfjpyUqtzTCUIwnyazJEDI7qvyvfH
 +HZqkoQ0HZ92WVsBUBPTM8/M0VOSxlECwqSwAwG3aazYSU5meOtdc2v0JczvEqL/iH9L
 +uUxZcR/qg8U+LicujY6kepx1rvmbBvDNsZUL1hQwh+vbkEyBLFm6M815YQp8BmWI5cP
 MUV51JSZAZd032ByuM3bJ52eePP9ylZt/LQhmy9oijEBRW7EjBq1a0x9zLrRZMIDozB9
 9JvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684855913; x=1687447913;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1+gXJ86s0iju1Tv+h9rhT2Zv/H7OCxTcxpLdnvZGHmE=;
 b=TrwsG1BQ1uJWQ4BKRYGN4eNGHT/LorLCQDTlr4wiFaHHhzgmYH56U7MAr0eSJSozr/
 d2t1k5m/bdJcQNFp0bvbMwSjnq0e0LXJ1X9FPozMqCH07ehZA0ngUDB+JCghIPGO99rD
 p+e/I9Qdx+keW8MUT1kdaxmMsj9YQrN+pWvtmBSCTGwqlKMp788ESvU1QZA2mv8IUguI
 XMCd8aeqPKw/+4sPVMd8h4JTY3YVpmWVEmFJR2/N2VVnlwIbFsE0PZYkp32/rW2PnQsX
 qYjjEL4QnDJ7PSH/ulXN7Ucb3WS0YVEB2Du+pPp2ouip5XF2EqemwJLXcEIRAEz6R7W6
 BY6g==
X-Gm-Message-State: AC+VfDwvNyDi2/cTbPtVrYdkKC82QOJJBbEdNTrNnYFSoqWXEZEQ0YQY
 l7U0VCH6ejQ3ndSW35NOT/0BpQ==
X-Google-Smtp-Source: ACHHUZ5wL+vzyQr9iqTRGVI1mloL/WaK6+xzpdk6fdiDaatYZBL9XNq2av2OdrbD9x4diIeqU2mDVQ==
X-Received: by 2002:a05:6a20:160e:b0:10b:6b1f:acf1 with SMTP id
 l14-20020a056a20160e00b0010b6b1facf1mr9627047pzj.29.1684855912611; 
 Tue, 23 May 2023 08:31:52 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:c13a:d73:4f88:3654?
 ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 r25-20020a632059000000b0053031f7a367sm6144199pgm.85.2023.05.23.08.31.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 08:31:52 -0700 (PDT)
Message-ID: <57f69ad1-2546-535b-75fe-f5e3d858504b@linaro.org>
Date: Tue, 23 May 2023 08:31:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Help finding Coverity defects for generated Hexagon code
Content-Language: en-US
To: anjo@rev.ng, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <6467d9133bd9f_57b172b16e2c9d98835043@prd-scan-dashboard-0.mail>
 <4ffdd486-ec7d-49c7-1330-0d0b090735b9@rev.ng>
 <CAFEAcA9ZctmXrCAwsAk6eBeF4ojB4QBwq16TsdcGZPHTin6LEg@mail.gmail.com>
 <CABgObfa7N+A=ReW-jme=Nx+wt7rZPcpuy-ANmxepcJMxeXeeWA@mail.gmail.com>
 <5de92654-52e3-6042-de5e-b2334b737c13@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <5de92654-52e3-6042-de5e-b2334b737c13@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 5/23/23 06:29, Anton Johansson via wrote:
> 
> On 5/23/23 12:29, Paolo Bonzini wrote:
>> On Tue, May 23, 2023 at 11:18 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>>> On Mon, 22 May 2023 at 21:24, Anton Johansson <anjo@rev.ng> wrote:
>>>> Hi,
>>>>
>>>> coverity recently reported some defects in code generated by idef-parser
>>>> (email attached). These defects are expected and we plan to emit a
>>>> /* coverity[event_tag] */ comment to disable the specific event triggered.
>>> We don't mark coverity false positives with comments in the
>>> source. For the free online scanner, we just mark them as
>>> false positives in the GUI (with an explanation of why they're
>>> false positives).
>> They aren't visible in the GUI because the whole "hexagon generated
>> files" component is marked as not-analyzed; which apparently means it
>> _is_ analyzed and visible in the emails but not in the GUI.
> 
> Ah right...
> 
>> The event tag for this error should be "dead_error_condition". In
>> theory, the hexagon generated files could be a good exception to the
>> rules that we don't mark false positives in the source, but finding
>> the right line to add the tag can be messy.
> If we decide to mark these in source, my plan was to simply emit
> 
>      if (qemu_tmp_2 >= 64) {
>          /* coverity[dead_error_condition] */
>          tcg_gen_movi_i64(tmp_5, 0);
>      } else {
>          tcg_gen_shli_i64(tmp_5, tmp_4, qemu_tmp_2);
>      }
> 
> for all of these safety checks around shifts/extracts where the defect could
> trigger. Maybe this is overreaching as we would also mark similar branches in
> other instructions that are alive, but if we knew they were dead at translation
> time we could simply not emit them to begin with.

It would be simpler to do better constant propagation and folding in the generator than to 
do the markup.  All of the cases for which it warns are really quite trivial.


r~

