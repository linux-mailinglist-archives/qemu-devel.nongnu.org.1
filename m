Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E880582DDA9
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 17:34:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPPu9-0000k8-Dl; Mon, 15 Jan 2024 11:33:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rPPto-0000i4-Q2
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 11:33:22 -0500
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rPPtj-0006JL-RR
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 11:33:18 -0500
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-598a5448ef5so3074942eaf.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 08:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705336391; x=1705941191; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=m507gAY0sa8GNq+MTSrkFdnXvyJZdKLbIGZHWnLl+GU=;
 b=FbFtcEOeeu/IVuc72DHD9lJDlnbaZgnl9nyTwCLVOq8n7foO6RfFtLYFvqBNt7h057
 XBPQ9A08Wt8zi10tbLn/DRWdFyDvv8DgHzKRu+v4IzWgS+j7iYDsgHY+Gkq0iLYwwUUm
 oqawJFO0GC4M8T6dXiCjDfJGGTTfZTTIlEsrvUN+7SBrhCMyaCaoH+KOwidlK0B1puE/
 FEO/Bk2vZoxSleE5kWcaa/mcc5heq78Whq4s/lxHTM49Rgj75TvV9nvrl9onCu+zZdCv
 mCjXdS0rw1EhgUCazvnPGqTzvBBM4wvLbpmTZjL/Xi4B2bnGlOgDsdfNTLaqqceQunwo
 J2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705336391; x=1705941191;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m507gAY0sa8GNq+MTSrkFdnXvyJZdKLbIGZHWnLl+GU=;
 b=jBcvvKxqG4Cobre84VzMQEli7heVv4wOZT4Oe43EFERNRngprKmz8sa6AQ6UOGFvFi
 pW9MUuO3/9B82hQVk+s0woaYMAmOfcLp3Nk4Z8qrGJEzFoBkua5qozEmoWmmfiTatDlR
 ZZVRMX+GK1eqJhY723Y7qc5AQm5DpnCjErjJquy8pU7CSRW20aThp62UfXusxCkt69BG
 F5XoR0SBRN0grKtvFjUgAYRLWIIxQFwYC8/FIBXDIVtn9v4De8Tg0tDGSyJ2wTY8Rf3Y
 NWszn+LD8w3iE48532CsIL05uFrJyyZEPn4KUbZVApHeUKZ7A3Ns/gQcV9OkHsmz2ber
 j43w==
X-Gm-Message-State: AOJu0YxLu9A7p6Bsj0awOjBXKaujuSa8xCcYnAG3QBqRtkgYtrNdD1KU
 3DX22C6hxUu6YYbZo8ow7dJ1o3lTF662kRIhQq9YtZV+rco=
X-Google-Smtp-Source: AGHT+IF+y2lxeNbMNzsCPDpufaxEgmQZrcaYQtzGC301LkvfrCRNR8fmuVe0LUIujrhgFhgddydf7zgYHKXUpvsxwII=
X-Received: by 2002:a05:6820:220b:b0:598:a76d:e3b0 with SMTP id
 cj11-20020a056820220b00b00598a76de3b0mr2893196oob.19.1705336391001; Mon, 15
 Jan 2024 08:33:11 -0800 (PST)
MIME-Version: 1.0
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 15 Jan 2024 11:32:59 -0500
Message-ID: <CAJSP0QX9TQ-=PD7apOamXvGW29VwJPfVNN2X5BsFLFoP2g6USg@mail.gmail.com>
Subject: Call for GSoC/Outreachy internship project ideas
To: qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>
Cc: Alberto Faria <afaria@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 German Maglione <gmaglione@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 "Richard W.M. Jones" <rjones@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Warner Losh <imp@bsdimp.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, Song Gao <gaosong@loongson.cn>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Bernhard Beschow <shentey@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Sean Christopherson <seanjc@google.com>,
 Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Dear QEMU and KVM communities,
QEMU will apply for the Google Summer of Code and Outreachy internship
programs again this year. Regular contributors can submit project
ideas that they'd like to mentor by replying to this email before
January 30th.

Internship programs
---------------------------
GSoC (https://summerofcode.withgoogle.com/) and Outreachy
(https://www.outreachy.org/) offer paid open source remote work
internships to eligible people wishing to participate in open source
development. QEMU has been part of these internship programs for many
years. Our mentors have enjoyed helping talented interns make their
first open source contributions and some former interns continue to
participate today.

Who can mentor
----------------------
Regular contributors to QEMU and KVM can participate as mentors.
Mentorship involves about 5 hours of time commitment per week to
communicate with the intern, review their patches, etc. Time is also
required during the intern selection phase to communicate with
applicants. Being a mentor is an opportunity to help someone get
started in open source development, will give you experience with
managing a project in a low-stakes environment, and a chance to
explore interesting technical ideas that you may not have time to
develop yourself.

How to propose your idea
----------------------------------
Reply to this email with the following project idea template filled in:

=== TITLE ===

'''Summary:''' Short description of the project

Detailed description of the project that explains the general idea,
including a list of high-level tasks that will be completed by the
project, and provides enough background for someone unfamiliar with
the codebase to do research. Typically 2 or 3 paragraphs.

'''Links:'''
* Wiki links to relevant material
* External links to mailing lists or web sites

'''Details:'''
* Skill level: beginner or intermediate or advanced
* Language: C/Python/Rust/etc

More information
----------------------
You can find out about the process we follow here:
Video: https://www.youtube.com/watch?v=xNVCX7YMUL8
Slides (PDF): https://vmsplice.net/~stefan/stefanha-kvm-forum-2016.pdf

The QEMU wiki page for GSoC 2024 is now available:
https://wiki.qemu.org/Google_Summer_of_Code_2024

Thanks,
Stefan

