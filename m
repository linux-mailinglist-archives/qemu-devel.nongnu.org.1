Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CBFAA107D
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Apr 2025 17:28:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9msU-0007k5-G3; Tue, 29 Apr 2025 11:28:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u9msC-0007Ux-Or
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 11:27:52 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u9msA-0005AM-8D
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 11:27:51 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5e677f59438so9673359a12.2
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 08:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745940465; x=1746545265; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/RuN7hWbYlGEh6Q9xsPeBHljyCxObtRUIbgSvnDDCD4=;
 b=cLSh15MXJgmuuytgCycYbIK7RidGfFQEP0kCxzfaFWEtqHDLy37o2ukxqmj7L7W/2g
 niYcKYul2Vwsxpyu+Y7bUQAPlTWEYC9Nk3Px6OSOAUc/oWRyZQ+CGcd6xbXVqN+iyOBe
 wbYdx2PTeNi8gIDXrjMVsYaWOL2AY32TImDwqb8u8B4xu8wQStkGvk3cJgEoQEehXEKO
 yYB+5q+e2tnsw4JY1tQG5MwYQI2C3U9JQXlI3toknSiQhNmo1hvdFwmiV5nm5PEdBtgu
 7X1+cJNeIFICRwwvHtl/zwbyCDMD8pKYza7Hj1+VmDgI9+ONdxKRxTI4i+65Dqd5iNM8
 mGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745940465; x=1746545265;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/RuN7hWbYlGEh6Q9xsPeBHljyCxObtRUIbgSvnDDCD4=;
 b=ZWOH8VpvXcLoroKjNfE81UGeU3IvxrhRoTGqBOFWYxz+ZTbIaYZQoF6eKqR3hAnC7J
 s/lTdeAxWvkcBL8Aip00VcpB5cscQpmbpT2VZGQDaMqdkgS+3v8xQ/HUyuqO8mpT8hS6
 kjj2NKKN/BxUdUIpUZCQ07gZKb8mLxkwaeLg/7LPGGgQ3vZUjm0uSVOhwKev+1uj4pXc
 bIwdpmJspVubgOwGlDO+x4eF+1HY6vqb3kYx12HFGi4EcmPEPArcvKUYRDiM82x5fz7D
 kwhrJqbWTsW2ClRPripMXmBzTpJKSQFlCFVQuIRkhPmPnhPuDixiexOwy9fM02w+G7UE
 ODfg==
X-Gm-Message-State: AOJu0YxqsUc4z+T2Iz3vM3ZzlJhI4HKxi4mUnF1LpkIixvC+mo+d+LZo
 KDVQB3HnqvVjOfeuXSI5Onhh7bV25aUvOELRnaJJkd2x2xghGES3/OijezUuD8JMZfeg9d96JJ0
 LCCw=
X-Gm-Gg: ASbGnctkSHbnHrQ5VvKvaF5luzfdru4ns6TmyA5LGnzXpU3OaCjqqGNgwgbRYTAz+5z
 +umw3ghheEaX3NyhMtYk24FL/B+oV70Lw1SklZACIFNNHcWWCFHfbDcLfQSyf+wlwKWlapUP7Ti
 JAGARBiImnXDGjx3voAb6eCe6cBfKysQED9QW6BH/G9pQGMZ4GWcEltf9v9A4JNhuaNw9UJjnzm
 IZQlEqidc4WYv6pQfzwMu4YkRDW0/LQEWGZsTRVm0uq5iqICOJdUHE0FAgxg5S9yDtr5rQ4leW4
 jsAYgBeME1iBn/oIyE5bfz3Gf5HFuJhWmAwFFFV8jm8=
X-Google-Smtp-Source: AGHT+IGHuzfvhcmdR/Z5KUUboYQ765ihs4SB0scTktklvL9k4RhDPSP9cx840UFmsMtKOO/pBAO48g==
X-Received: by 2002:a17:907:9495:b0:aca:cac7:28e2 with SMTP id
 a640c23a62f3a-acec4eb540bmr385308666b.40.1745940464693; 
 Tue, 29 Apr 2025 08:27:44 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ace6e4e726dsm793594366b.40.2025.04.29.08.27.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 08:27:44 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3CEAD5F863;
 Tue, 29 Apr 2025 16:27:43 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org,  qemu-ppc@nongnu.org,  Nicholas Piggin
 <npiggin@gmail.com>,  Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [RFC PATCH] target/ppc: Inline most of dcbz helper
In-Reply-To: <e4fc537a-a15e-77dd-1167-32b12ee7a22d@eik.bme.hu> (BALATON
 Zoltan's message of "Mon, 28 Apr 2025 15:26:07 +0200 (CEST)")
References: <20240701005939.5A0AF4E6000@zero.eik.bme.hu>
 <d3c6c417-20d9-a215-2a5c-86fa084b00fa@eik.bme.hu>
 <173c9111-e065-0dd5-c276-6bbc0351f9cc@eik.bme.hu>
 <2b969dcd-4a82-9086-803d-c52ea274fefb@eik.bme.hu>
 <e4fc537a-a15e-77dd-1167-32b12ee7a22d@eik.bme.hu>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Tue, 29 Apr 2025 16:27:43 +0100
Message-ID: <87bjsf3s40.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

BALATON Zoltan <balaton@eik.bme.hu> writes:

> On Mon, 28 Apr 2025, BALATON Zoltan wrote:
>> On Mon, 28 Apr 2025, BALATON Zoltan wrote:
>>> On Thu, 24 Apr 2025, BALATON Zoltan wrote:
>>>>> The test case I've used came out of a discussion about very slow
>>>>> access to VRAM of a graphics card passed through with vfio the reason
>>>>> for which is still not clear but it was already known that dcbz is
>>>>> often used by MacOS and AmigaOS for clearing memory and to avoid
>>>>> reading values about to be overwritten which is faster on real CPU but
>>>>> was found to be slower on QEMU. The optimised copy routines were
>>>>> posted here:
<snip>
>
> I have tried profiling the dst in real card vfio vram with dcbz case
> (with 100 iterations instead of 10000 in above tests) but I'm not sure
> I understand the results. vperm and dcbz show up but not too high. Can
> somebody explain what is happening here and where the overhead likely
> comes from? Here is the profile result I got:
>
> Samples: 104K of event 'cycles:Pu', Event count (approx.): 122371086557
>   Children      Self  Command          Shared Object            Symbol
> -   99.44%     0.95%  qemu-system-ppc  qemu-system-ppc          [.] cpu_e=
xec_loop
>    - 98.49% cpu_exec_loop
>       - 98.48% cpu_tb_exec
>          - 90.95% 0x7f4e705d8f15
>               helper_ldub_mmu
>               do_ld_mmio_beN
>             - cpu_io_recompile

This looks like the dbz instructions are being used to clear device
memory and tripping over the can_do_io check (normally the translator
tries to ensure all device access is at the end of a block).

You could try ending the block on dbz instructions and seeing if that
helps. Normally I would expect the helper to be more efficient as it can
probe the whole address range once and then use host insns to blat the
memory.

>                - 45.79% cpu_loop_exit_noexc
>                   - cpu_loop_exit
>                     __longjmp_chk
>                     cpu_exec_setjmp
>                   - cpu_exec_loop
>                      - 45.78% cpu_tb_exec
>                           42.35% 0x7f4e6f3f0000
>                         - 0.72% 0x7f4e99f37037
>                              helper_VPERM
>                         - 0.68% 0x7f4e99f3716d
>                              helper_VPERM
>                - 45.16% rr_cpu_thread_fn

Hmm you seem to be running in icount mode here for some reason.

>                   - 45.16% tcg_cpu_exec
>                      - 45.15% cpu_exec
>                         - 45.15% cpu_exec_setjmp
>                            - cpu_exec_loop
>                               - 45.14% cpu_tb_exec
>                                    42.08% 0x7f4e6f3f0000
>                                  - 0.72% 0x7f4e99f37037
>                                       helper_VPERM
>                                  - 0.67% 0x7f4e99f3716d
>                                       helper_VPERM
<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

