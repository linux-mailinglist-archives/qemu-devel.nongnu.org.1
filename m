Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 64AA5977CE5
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Sep 2024 12:07:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp3CK-00070P-Uy; Fri, 13 Sep 2024 06:06:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sp3CI-0006zl-7N
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 06:06:38 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sp3CD-0000Zg-8k
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 06:06:37 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-5365d3f9d34so898669e87.3
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 03:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726221991; x=1726826791; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XHaKc22Z5nFoNlSJPLTuVtiOXSo3UsZQUqNG6UirA+w=;
 b=anrWmtEw5z3wN2OFIx0ST6Q/hBRaLGE/zwrwo0ZoZvVxo501HAwsHCqFgDcXFGfGyE
 jpEjdh5ACyA+hQ3QJ9Rgs87L4uRYJUzSSLZp8hYAL5DGb/4Y/eSHMO4GGNCjkoPeznt5
 HSm56JjusrFd9ZkyG29BQv018EBcR6zPzPjfeZMA59Xc3cC1W94q3a+4xdJj35W4OWaw
 xu+8YnhzwTdbY+XAlmcgfNh+CT/X1gaMG6Mg4DY9TvH0/7IGh+SzEFEGcEF2okn/wihP
 pYHWs6U4fG9+aFrhmlk+IJ5sVao3RmHFDrugE6pLpeNsxNhzitj2ktA1R6CD46m409ex
 KE2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726221991; x=1726826791;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XHaKc22Z5nFoNlSJPLTuVtiOXSo3UsZQUqNG6UirA+w=;
 b=kdKQNoCE7pVlfUwwAo3JUpYoBVwx0BXC/VvzM9OEbZrZ6eqlJbFlEXOPgZkXeDb8T2
 sBWCRjzu3TtFisjoSp7OG+laorX5c2euaY8NTO2Rf4itvPDQ6NQ6DkgItPLLxRrsoIGq
 KxqPyANIDDdLUYfjrIta5hJTeoyOZJOu/YjdyiuGkxwJGrnMaHoU+3HqUm7fv4s/ubzL
 MYw4rWwJqYKAEbYd/voSKAHoloLqL7xKY1vjeukKvjkGgQHl842ykilG8foMCTp2QQRm
 RnwraFEsI+EOmcoEF11GjwncrZxyVwHTqmfkOVJ8uVFzz79YDOxuxxt+5YF5pEl8hB8b
 fuHw==
X-Gm-Message-State: AOJu0YwA40waDMalDyvbPnKQkmajy9vHVqal+2HOsIubNrk4O5DROCF9
 Vi1NtTuc5uy6XDZ/Dan4gTLzW6VWhXC93FIlHh6pWT0qCj58nYbiSQaFbMzP154=
X-Google-Smtp-Source: AGHT+IFyB2YLNZ6EAomxlBjLFrRa5MIUYd+XMRFfBc+ufau4zPtANnHMWdZshyATnZQFYsh1gkfOrw==
X-Received: by 2002:a05:6512:1093:b0:536:54fd:275b with SMTP id
 2adb3069b0e04-5367ff32462mr1399252e87.54.1726221989680; 
 Fri, 13 Sep 2024 03:06:29 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25c7286esm844231766b.138.2024.09.13.03.06.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 03:06:28 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 92A105F8B7;
 Fri, 13 Sep 2024 11:06:27 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Elisha Hollander <just4now666666@gmail.com>
Cc: qemu-devel@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/1] allow using a higher icount
In-Reply-To: <CACkyd_YYUJYt3jAduOuaWiKcUAMKy3tGNp6Fuh6sHKMB=ZpTyw@mail.gmail.com>
 (Elisha Hollander's message of "Tue, 3 Sep 2024 18:28:26 +0300")
References: <20240816162044.5764-1-just4now666666@gmail.com>
 <871q2ae24s.fsf@draig.linaro.org>
 <CACkyd_anZKrjNUKE+nwzSvJGQwxQ2zq2J8sGawq3pKYLVT9vXQ@mail.gmail.com>
 <CACkyd_ZNPzhg8pqkdLucyJ70wZKJARR_65r5CJBy0+U=7GR_1Q@mail.gmail.com>
 <87h6b452m5.fsf@draig.linaro.org>
 <CACkyd_YG-r837VfoPaOw5bKCczAUQYFOobW=2SF37esppbc0XQ@mail.gmail.com>
 <CACkyd_ZhByWwPQtFmHGRQxmBcVwCEyeSKX6fqhS3K=1480ASOA@mail.gmail.com>
 <87wmjudwyp.fsf@draig.linaro.org>
 <CACkyd_YpxVdGC04cEEPr4O44P+FQ9P51T32AtBxCmOVV1b9f-g@mail.gmail.com>
 <87jzftdol5.fsf@draig.linaro.org> <87bk15dm7k.fsf@draig.linaro.org>
 <CACkyd_YYUJYt3jAduOuaWiKcUAMKy3tGNp6Fuh6sHKMB=ZpTyw@mail.gmail.com>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Fri, 13 Sep 2024 11:06:27 +0100
Message-ID: <87o74rrhp8.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12f.google.com
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

Elisha Hollander <just4now666666@gmail.com> writes:

> weird...

Richard has posted some patches:

  Message-ID: <20240910212351.977753-1-richard.henderson@linaro.org>
  Date: Tue, 10 Sep 2024 14:23:49 -0700
  Subject: [PATCH 0/2] tcg: Fix branch/label link during plugin expansion
  From: Richard Henderson <richard.henderson@linaro.org>

which work for me. Can you try them out?

>
> On Tue, Sep 3, 2024, 14:13 Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
>  Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>
>  > Elisha Hollander <just4now666666@gmail.com> writes:
>  >
>  >> Sure!
>  >>
>  >> `build/qemu-system-i386 -plugin build/contrib/plugins/libips.so,ips=
=3D1 -display curses -bios bios.raw`
>  >>
>  >> Also, I just tested with 9.1.0-rc4 and it resulted with
>  >> `tcg.c:3167:remove_label_use: code should not be reached`
>  >
>  > I can replicate but it seems to be an edge case with ips=3D1, try a hi=
gher
>  > number, even ips=3D10 doesn't trigger the crash (but 10 instructions a
>  > second is very slow to do anything).
>  >
>  >   ./qemu-system-i386  -plugin contrib/plugins/libips.so,ips=3D1 -displ=
ay none -serial mon:stdio
>  >   **
>  >   ERROR:../../tcg/tcg.c:3167:remove_label_use: code should not be reac=
hed
>  >   Bail out! ERROR:../../tcg/tcg.c:3167:remove_label_use: code should n=
ot be reached
>  >   fish: Job 1, './qemu-system-i386  -plugin con=E2=80=A6' terminated b=
y signal
>  >   SIGABRT (Abort)
>
>  Well this is fascinating and I suspect Richard needs to comment but:
>
>    ./qemu-system-i386  -plugin contrib/plugins/libips.so,ips=3D9 -display=
 none -serial mon:stdio -d in_asm,op,op_opt,out_asm
>  -plugin contrib/plugins/libstoptrigger.so,icount=3D20 -D broken.log
>    **
>    ERROR:../../tcg/tcg.c:3167:remove_label_use: code should not be reached
>    Bail out! ERROR:../../tcg/tcg.c:3167:remove_label_use: code should not=
 be reached
>    fish: Job 1, './qemu-system-i386  -plugin con=E2=80=A6' terminated by =
signal SIGABRT (Abort)
>
>  and:
>
>   ./qemu-system-i386  -plugin contrib/plugins/libips.so,ips=3D10 -display=
 none -serial mon:stdio -d in_asm,op,op_opt,out_asm
>  -plugin contrib/plugins/libstoptrigger.so,icount=3D20 -D working.log
>
>  But for the life of me I can't see the difference between the two sets
>  of input, the first crashes before the optimisation step:
>
>  PROLOGUE: [size=3D45]
>  0x7f2198000000:  55                       pushq    %rbp
>  0x7f2198000001:  53                       pushq    %rbx
>  0x7f2198000002:  41 54                    pushq    %r12
>  0x7f2198000004:  41 55                    pushq    %r13
>  0x7f2198000006:  41 56                    pushq    %r14
>  0x7f2198000008:  41 57                    pushq    %r15
>  0x7f219800000a:  48 8b ef                 movq     %rdi, %rbp
>  0x7f219800000d:  48 81 c4 78 fb ff ff     addq     $-0x488, %rsp
>  0x7f2198000014:  ff e6                    jmpq     *%rsi
>  0x7f2198000016:  33 c0                    xorl     %eax, %eax
>  0x7f2198000018:  48 81 c4 88 04 00 00     addq     $0x488, %rsp
>  0x7f219800001f:  c5 f8 77                 vzeroupper=20
>  0x7f2198000022:  41 5f                    popq     %r15
>  0x7f2198000024:  41 5e                    popq     %r14
>  0x7f2198000026:  41 5d                    popq     %r13
>  0x7f2198000028:  41 5c                    popq     %r12
>  0x7f219800002a:  5b                       popq     %rbx
>  0x7f219800002b:  5d                       popq     %rbp
>  0x7f219800002c:  c3                       retq=20=20=20=20=20
>
>  ----------------
>  IN:=20
>  0xfffffff0:  ea 5b e0 00 f0           ljmpw    $0xf000:$0xe05b
>
>  OP:
>   ld_i32 loc9,env,$0xfffffffffffffff8
>   brcond_i32 loc9,$0x0,lt,$L0
>   ld_i32 tmp18,env,$0xffffffffffffdaf8
>   mul_i32 tmp18,tmp18,$0x18
>   ext_i32_i64 tmp17,tmp18
>   add_i64 tmp17,tmp17,$0x55912c381e38
>   ld_i64 tmp21,tmp17,$0x0
>   add_i64 tmp21,tmp21,$0x1
>   st_i64 tmp21,tmp17,$0x0
>   ld_i32 tmp18,env,$0xffffffffffffdaf8
>   mul_i32 tmp18,tmp18,$0x18
>   ext_i32_i64 tmp17,tmp18
>   add_i64 tmp17,tmp17,$0x55912c381e38
>   ld_i64 tmp21,tmp17,$0x0
>   brcond_i64 tmp21,$0x0,ltu,$L1
>   ld_i32 tmp18,env,$0xffffffffffffdaf8
>   call plugin(0x7f21efe82550),$0x1,$0,tmp18,$0x0
>   set_label $L1
>   st8_i32 $0x1,env,$0xfffffffffffffffc
>
>   ---- 0000000000000ff0 0000000000000000
>   ld_i32 tmp18,env,$0xffffffffffffdaf8
>   shl_i32 tmp18,tmp18,$0x3
>   ext_i32_i64 tmp17,tmp18
>   add_i64 tmp17,tmp17,$0x55912c3803b0
>   ld_i64 tmp21,tmp17,$0x0
>   add_i64 tmp21,tmp21,$0x1
>   st_i64 tmp21,tmp17,$0x0
>   ld_i32 tmp18,env,$0xffffffffffffdaf8
>   shl_i32 tmp18,tmp18,$0x3
>   ext_i32_i64 tmp17,tmp18
>   add_i64 tmp17,tmp17,$0x55912c3803b0
>   ld_i64 tmp21,tmp17,$0x0
>   brcond_i64 tmp21,$0x15,ne,$L2
>   ld_i32 tmp18,env,$0xffffffffffffdaf8
>   call plugin(0x7f21efe7d420),$0x1,$0,tmp18,$0xfffffff0
>   set_label $L2
>   mov_i32 loc0,$0xe05b
>   mov_i32 loc1,$0xf000
>   ext16u_i32 loc13,loc1
>   st_i32 loc13,env,$0x54
>   shl_i32 cs_base,loc13,$0x4
>   mov_i32 eip,loc0
>   call lookup_tb_ptr,$0x6,$1,tmp15,env
>   goto_ptr tmp15
>   set_label $L0
>   exit_tb $0x7f2198000043
>
>   BOOM!!!
>
>  and the working case:
>
>  PROLOGUE: [size=3D45]
>  0x7f110c000000:  55                       pushq    %rbp
>  0x7f110c000001:  53                       pushq    %rbx
>  0x7f110c000002:  41 54                    pushq    %r12
>  0x7f110c000004:  41 55                    pushq    %r13
>  0x7f110c000006:  41 56                    pushq    %r14
>  0x7f110c000008:  41 57                    pushq    %r15
>  0x7f110c00000a:  48 8b ef                 movq     %rdi, %rbp
>  0x7f110c00000d:  48 81 c4 78 fb ff ff     addq     $-0x488, %rsp
>  0x7f110c000014:  ff e6                    jmpq     *%rsi
>  0x7f110c000016:  33 c0                    xorl     %eax, %eax
>  0x7f110c000018:  48 81 c4 88 04 00 00     addq     $0x488, %rsp
>  0x7f110c00001f:  c5 f8 77                 vzeroupper=20
>  0x7f110c000022:  41 5f                    popq     %r15
>  0x7f110c000024:  41 5e                    popq     %r14
>  0x7f110c000026:  41 5d                    popq     %r13
>  0x7f110c000028:  41 5c                    popq     %r12
>  0x7f110c00002a:  5b                       popq     %rbx
>  0x7f110c00002b:  5d                       popq     %rbp
>  0x7f110c00002c:  c3                       retq=20=20=20=20=20
>
>  ----------------
>  IN:=20
>  0xfffffff0:  ea 5b e0 00 f0           ljmpw    $0xf000:$0xe05b
>
>  OP:
>   ld_i32 loc9,env,$0xfffffffffffffff8
>   brcond_i32 loc9,$0x0,lt,$L0
>   ld_i32 tmp18,env,$0xffffffffffffdaf8
>   mul_i32 tmp18,tmp18,$0x18
>   ext_i32_i64 tmp17,tmp18
>   add_i64 tmp17,tmp17,$0x55c2cb346e38
>   ld_i64 tmp21,tmp17,$0x0
>   add_i64 tmp21,tmp21,$0x1
>   st_i64 tmp21,tmp17,$0x0
>   ld_i32 tmp18,env,$0xffffffffffffdaf8
>   mul_i32 tmp18,tmp18,$0x18
>   ext_i32_i64 tmp17,tmp18
>   add_i64 tmp17,tmp17,$0x55c2cb346e38
>   ld_i64 tmp21,tmp17,$0x0
>   brcond_i64 tmp21,$0x1,ltu,$L1
>   ld_i32 tmp18,env,$0xffffffffffffdaf8
>   call plugin(0x7f11633ab550),$0x1,$0,tmp18,$0x0
>   set_label $L1
>   st8_i32 $0x1,env,$0xfffffffffffffffc
>
>   ---- 0000000000000ff0 0000000000000000
>   ld_i32 tmp18,env,$0xffffffffffffdaf8
>   shl_i32 tmp18,tmp18,$0x3
>   ext_i32_i64 tmp17,tmp18
>   add_i64 tmp17,tmp17,$0x55c2cb3453b0
>   ld_i64 tmp21,tmp17,$0x0
>   add_i64 tmp21,tmp21,$0x1
>   st_i64 tmp21,tmp17,$0x0
>   ld_i32 tmp18,env,$0xffffffffffffdaf8
>   shl_i32 tmp18,tmp18,$0x3
>   ext_i32_i64 tmp17,tmp18
>   add_i64 tmp17,tmp17,$0x55c2cb3453b0
>   ld_i64 tmp21,tmp17,$0x0
>   brcond_i64 tmp21,$0x15,ne,$L2
>   ld_i32 tmp18,env,$0xffffffffffffdaf8
>   call plugin(0x7f11633a6420),$0x1,$0,tmp18,$0xfffffff0
>   set_label $L2
>   mov_i32 loc0,$0xe05b
>   mov_i32 loc1,$0xf000
>   ext16u_i32 loc13,loc1
>   st_i32 loc13,env,$0x54
>   shl_i32 cs_base,loc13,$0x4
>   mov_i32 eip,loc0
>   call lookup_tb_ptr,$0x6,$1,tmp15,env
>   goto_ptr tmp15
>   set_label $L0
>   exit_tb $0x7f110c000043
>
>  OP after optimization and liveness analysis:
>   ld_i32 tmp9,env,$0xfffffffffffffff8      pref=3D0xffff
>   brcond_i32 tmp9,$0x0,lt,$L0              dead: 0 1
>   ld_i32 tmp18,env,$0xffffffffffffdaf8     pref=3D0xffff
>   mul_i32 tmp18,tmp18,$0x18                dead: 1  pref=3D0xffff
>   ext_i32_i64 tmp17,tmp18                  dead: 1  pref=3D0xffff
>   add_i64 tmp17,tmp17,$0x55c2cb346e38      dead: 1  pref=3D0xffff
>   ld_i64 tmp21,tmp17,$0x0                  pref=3D0xffff
>   add_i64 tmp21,tmp21,$0x1                 dead: 1  pref=3D0xffff
>   st_i64 tmp21,tmp17,$0x0                  dead: 0 1
>   ld_i32 tmp18,env,$0xffffffffffffdaf8     pref=3D0xffff
>   mul_i32 tmp18,tmp18,$0x18                dead: 1 2  pref=3D0xffff
>   ext_i32_i64 tmp17,tmp18                  dead: 1  pref=3D0xffff
>   add_i64 tmp17,tmp17,$0x55c2cb346e38      dead: 1 2  pref=3D0xffff
>   ld_i64 tmp21,tmp17,$0x0                  dead: 1  pref=3D0xffff
>   brcond_i64 tmp21,$0x1,ltu,$L1            dead: 0 1
>   ld_i32 tmp18,env,$0xffffffffffffdaf8     dead: 1  pref=3D0x80
>   call plugin(0x7f11633ab550),$0x1,$0,tmp18,$0x0  dead: 0 1
>   set_label $L1=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20
>   st8_i32 $0x1,env,$0xfffffffffffffffc     dead: 0
>
>   ---- 0000000000000ff0 0000000000000000
>   ld_i32 tmp18,env,$0xffffffffffffdaf8     pref=3D0xffff
>   shl_i32 tmp18,tmp18,$0x3                 dead: 1  pref=3D0xffff
>   ext_i32_i64 tmp17,tmp18                  dead: 1  pref=3D0xffff
>   add_i64 tmp17,tmp17,$0x55c2cb3453b0      dead: 1  pref=3D0xffff
>   ld_i64 tmp21,tmp17,$0x0                  pref=3D0xffff
>   add_i64 tmp21,tmp21,$0x1                 dead: 1 2  pref=3D0xffff
>   st_i64 tmp21,tmp17,$0x0                  dead: 0 1
>   ld_i32 tmp18,env,$0xffffffffffffdaf8     pref=3D0xffff
>   shl_i32 tmp18,tmp18,$0x3                 dead: 1 2  pref=3D0xffff
>   ext_i32_i64 tmp17,tmp18                  dead: 1  pref=3D0xffff
>   add_i64 tmp17,tmp17,$0x55c2cb3453b0      dead: 1 2  pref=3D0xffff
>   ld_i64 tmp21,tmp17,$0x0                  dead: 1  pref=3D0xffff
>   brcond_i64 tmp21,$0x15,ne,$L2            dead: 0 1
>   ld_i32 tmp18,env,$0xffffffffffffdaf8     dead: 1  pref=3D0x80
>   call plugin(0x7f11633a6420),$0x1,$0,tmp18,$0xfffffff0  dead: 0 1
>   set_label $L2=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20
>   st_i32 $0xf000,env,$0x54                 dead: 0
>   mov_i32 cs_base,$0xf0000                 sync: 0  dead: 0 1  pref=3D0xf=
fff
>   mov_i32 eip,$0xe05b                      sync: 0  dead: 0 1  pref=3D0xf=
fff
>   call lookup_tb_ptr,$0x6,$1,tmp15,env     dead: 1  pref=3Dnone
>   goto_ptr tmp15                           dead: 0
>   set_label $L0=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20
>   exit_tb $0x7f110c000043=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
>
>  OUT: [size=3D224]
>    -- guest addr 0x0000000000000ff0 + tb prologue
>  0x7f110c000100:  8b 5d f8                 movl     -8(%rbp), %ebx
>  0x7f110c000103:  85 db                    testl    %ebx, %ebx
>  0x7f110c000105:  0f 8c bd 00 00 00        jl       0x7f110c0001c8
>  0x7f110c00010b:  8b 9d f8 da ff ff        movl     -0x2508(%rbp), %ebx
>  0x7f110c000111:  6b db 18                 imull    $0x18, %ebx, %ebx
>  0x7f110c000114:  48 63 db                 movslq   %ebx, %rbx
>  0x7f110c000117:  49 bc 38 6e 34 cb c2 55  movabsq  $0x55c2cb346e38, %r12
>  0x7f110c00011f:  00 00
>  0x7f110c000121:  49 03 dc                 addq     %r12, %rbx
>  0x7f110c000124:  4c 8b 2b                 movq     (%rbx), %r13
>  0x7f110c000127:  49 ff c5                 incq     %r13
>  0x7f110c00012a:  4c 89 2b                 movq     %r13, (%rbx)
>  0x7f110c00012d:  8b 9d f8 da ff ff        movl     -0x2508(%rbp), %ebx
>  0x7f110c000133:  6b db 18                 imull    $0x18, %ebx, %ebx
>  0x7f110c000136:  48 63 db                 movslq   %ebx, %rbx
>  0x7f110c000139:  49 03 dc                 addq     %r12, %rbx
>  0x7f110c00013c:  48 8b 1b                 movq     (%rbx), %rbx
>  0x7f110c00013f:  48 83 fb 01              cmpq     $1, %rbx
>  0x7f110c000143:  0f 82 0d 00 00 00        jb       0x7f110c000156
>  0x7f110c000149:  8b bd f8 da ff ff        movl     -0x2508(%rbp), %edi
>  0x7f110c00014f:  33 f6                    xorl     %esi, %esi
>  0x7f110c000151:  e8 fa b3 3a 57           callq    0x7f11633ab550
>  0x7f110c000156:  c6 45 fc 01              movb     $1, -4(%rbp)
>  0x7f110c00015a:  8b 9d f8 da ff ff        movl     -0x2508(%rbp), %ebx
>  0x7f110c000160:  c1 e3 03                 shll     $3, %ebx
>  0x7f110c000163:  48 63 db                 movslq   %ebx, %rbx
>  0x7f110c000166:  49 bc b0 53 34 cb c2 55  movabsq  $0x55c2cb3453b0, %r12
>  0x7f110c00016e:  00 00
>  0x7f110c000170:  49 03 dc                 addq     %r12, %rbx
>  0x7f110c000173:  4c 8b 2b                 movq     (%rbx), %r13
>  0x7f110c000176:  49 ff c5                 incq     %r13
>  0x7f110c000179:  4c 89 2b                 movq     %r13, (%rbx)
>  0x7f110c00017c:  8b 9d f8 da ff ff        movl     -0x2508(%rbp), %ebx
>  0x7f110c000182:  c1 e3 03                 shll     $3, %ebx
>  0x7f110c000185:  48 63 db                 movslq   %ebx, %rbx
>  0x7f110c000188:  49 03 dc                 addq     %r12, %rbx
>  0x7f110c00018b:  48 8b 1b                 movq     (%rbx), %rbx
>  0x7f110c00018e:  48 83 fb 15              cmpq     $0x15, %rbx
>  0x7f110c000192:  0f 85 10 00 00 00        jne      0x7f110c0001a8
>  0x7f110c000198:  8b bd f8 da ff ff        movl     -0x2508(%rbp), %edi
>  0x7f110c00019e:  be f0 ff ff ff           movl     $0xfffffff0, %esi
>  0x7f110c0001a3:  e8 78 62 3a 57           callq    0x7f11633a6420
>  0x7f110c0001a8:  c7 45 54 00 f0 00 00     movl     $0xf000, 0x54(%rbp)
>  0x7f110c0001af:  c7 45 58 00 00 0f 00     movl     $0xf0000, 0x58(%rbp)
>  0x7f110c0001b6:  c7 45 20 5b e0 00 00     movl     $0xe05b, 0x20(%rbp)
>  0x7f110c0001bd:  48 8b fd                 movq     %rbp, %rdi
>  0x7f110c0001c0:  ff 15 12 00 00 00        callq    *0x12(%rip)
>  0x7f110c0001c6:  ff e0                    jmpq     *%rax
>  0x7f110c0001c8:  48 8d 05 74 fe ff ff     leaq     -0x18c(%rip), %rax
>  0x7f110c0001cf:  e9 44 fe ff ff           jmp      0x7f110c000018
>    -- tb slow paths + alignment
>  0x7f110c0001d4:  90                       nop=20=20=20=20=20=20
>  0x7f110c0001d5:  90                       nop=20=20=20=20=20=20
>  0x7f110c0001d6:  90                       nop=20=20=20=20=20=20
>  0x7f110c0001d7:  90                       nop=20=20=20=20=20=20
>    data: [size=3D8]
>  0x7f110c0001d8:  .quad  0x000055c2ba75abc0
>
>  before continuing to execute.
>
>  >
>  >
>  >>
>  >> On Mon, Sep 2, 2024, 16:08 Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>  >>
>  >>  Elisha Hollander <just4now666666@gmail.com> writes:
>  >>
>  >>  > But for qemu_plugin_update_ns
>  >>  >
>  >>  > On Mon, Sep 2, 2024, 15:38 Elisha Hollander <just4now666666@gmail.=
com> wrote:
>  >>  >
>  >>  >  Just checked with 9.0.2 it it still gives the error...
>  >>  >
>  >>  >  On Wed, Aug 28, 2024, 14:05 Alex Benn=C3=A9e <alex.bennee@linaro.=
org> wrote:
>  >>  >
>  >>  >  Elisha Hollander <just4now666666@gmail.com> writes:
>  >>  >
>  >>  >  > Although it gives `undefined symbol: qemu_plugin_scoreboard_fre=
e`. But
>  >>  >  > probably I messed something up...
>  >>  >
>  >>  >  Are you using an older QEMU? We should trigger an API warning if =
they
>  >>  >  are mismatched but maybe thats not working.
>  >>  >
>  >>  >  >
>  >>  >  > On Tue, Aug 27, 2024, 14:59 Elisha Hollander <just4now666666@gm=
ail.com> wrote:
>  >>  >  >
>  >>  >  >  Oh nice, I didn't know that
>  >>  >  >
>  >>  >  >  On Tue, Aug 27, 2024, 12:39 Alex Benn=C3=A9e <alex.bennee@lina=
ro.org> wrote:
>  >>  >  >
>  >>  >  >  Elisha Hollander <just4now666666@gmail.com> writes:
>  >>  >  >
>  >>  >  >  > Signed-off-by: Elisha Hollander <just4now666666@gmail.com>
>  >>  >  >
>  >>  >  >  What is the use-case for this patch?
>  >>  >  >
>  >>  >  >  If you are simply looking to slow the emulated system down ple=
ase have a
>  >>  >  >  look at:
>  >>  >  >
>  >>  >  >    https://qemu.readthedocs.io/en/master/about/emulation.html#l=
imit-instructions-per-second
>  >>  >  >
>  >>  >  >  which uses the plugin system to limit the run rate and sleep i=
f its
>  >>  >  >  running too fast. The longer term goal is to deprecate the ico=
unt clock
>  >>  >  >  alignment feature from the core code and leave icount to just =
provide
>  >>  >  >  the deterministic execution needed for record/replay and rever=
se
>  >>  >  >  debugging.
>  >>  >  >
>  >>  >  >  > ---
>  >>  >  >  >  accel/tcg/cpu-exec.c      | 4 +---
>  >>  >  >  >  accel/tcg/icount-common.c | 4 ++--
>  >>  >  >  >  2 files changed, 3 insertions(+), 5 deletions(-)
>  >>  >  >  >
>  >>  >  >  > diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
>  >>  >  >  > index 8163295f34..4c2baf8ed4 100644
>  >>  >  >  > --- a/accel/tcg/cpu-exec.c
>  >>  >  >  > +++ b/accel/tcg/cpu-exec.c
>  >>  >  >  > @@ -95,11 +95,10 @@ static void align_clocks(SyncClocks *sc,=
 CPUState *cpu)
>  >>  >  >  >  static void print_delay(const SyncClocks *sc)
>  >>  >  >  >  {
>  >>  >  >  >      static float threshold_delay;
>  >>  >  >  > -    static int64_t last_realtime_clock;
>  >>  >  >  >      static int nb_prints;
>  >>  >  >  >=20=20
>  >>  >  >  >      if (icount_align_option &&
>  >>  >  >  > -        sc->realtime_clock - last_realtime_clock >=3D MAX_D=
ELAY_PRINT_RATE &&
>  >>  >  >  > +        sc->diff_clk >=3D MAX_DELAY_PRINT_RATE &&
>  >>  >  >  >          nb_prints < MAX_NB_PRINTS) {
>  >>  >  >  >          if ((-sc->diff_clk / (float)1000000000LL > threshol=
d_delay) ||
>  >>  >  >  >              (-sc->diff_clk / (float)1000000000LL <
>  >>  >  >  > @@ -109,7 +108,6 @@ static void print_delay(const SyncClocks=
 *sc)
>  >>  >  >  >                          threshold_delay - 1,
>  >>  >  >  >                          threshold_delay);
>  >>  >  >  >              nb_prints++;
>  >>  >  >  > -            last_realtime_clock =3D sc->realtime_clock;
>  >>  >  >  >          }
>  >>  >  >  >      }
>  >>  >  >  >  }
>  >>  >  >  > diff --git a/accel/tcg/icount-common.c b/accel/tcg/icount-co=
mmon.c
>  >>  >  >  > index 8d3d3a7e9d..f07f8baf4d 100644
>  >>  >  >  > --- a/accel/tcg/icount-common.c
>  >>  >  >  > +++ b/accel/tcg/icount-common.c
>  >>  >  >  > @@ -46,8 +46,8 @@
>  >>  >  >  >   * is TCG-specific, and does not need to be built for other=
 accels.
>  >>  >  >  >   */
>  >>  >  >  >  static bool icount_sleep =3D true;
>  >>  >  >  > -/* Arbitrarily pick 1MIPS as the minimum allowable speed.  =
*/
>  >>  >  >  > -#define MAX_ICOUNT_SHIFT 10
>  >>  >  >  > +/* Arbitrarily pick the minimum allowable speed.  */
>  >>  >  >  > +#define MAX_ICOUNT_SHIFT 30
>  >>  >  >  >=20=20
>  >>  >  >  >  /* Do not count executed instructions */
>  >>  >  >  >  ICountMode use_icount =3D ICOUNT_DISABLED;
>  >>  >  >
>  >>  >  >  --=20
>  >>  >  >  Alex Benn=C3=A9e
>  >>  >  >  Virtualisation Tech Lead @ Linaro
>  >>  >
>  >>  >  --=20
>  >>  >  Alex Benn=C3=A9e
>  >>  >  Virtualisation Tech Lead @ Linaro
>  >>
>  >>  Can you give me your command line please?
>  >>
>  >>  --=20
>  >>  Alex Benn=C3=A9e
>  >>  Virtualisation Tech Lead @ Linaro
>
>  --=20
>  Alex Benn=C3=A9e
>  Virtualisation Tech Lead @ Linaro

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

