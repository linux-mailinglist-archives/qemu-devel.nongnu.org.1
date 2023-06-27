Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F9773EFA6
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 02:25:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDwUW-0004lT-Sv; Mon, 26 Jun 2023 20:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1qDwUT-0004lJ-4H
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 20:23:29 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1qDwUP-00047F-30
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 20:23:27 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1b80bce2592so8147295ad.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 17:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687825401; x=1690417401;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vkR+aXtbcLQFi+Ub06iKUMr1Y/Aix+/+v5uVmme69LI=;
 b=i68lB+/WLF+RcB5VgLj3n+ns4TCBSZwRrervwKiLr89dPFLq1PYw1N1zFgndmLo1+q
 5cJ6zMEZn/d5cgRQUJ88bi/qn6MUcCBQIiogQgvjWIkNfgmHzrulnAg+KhqE7XU2R1Z8
 g60h/eE09BybvSFeQ186t6ZsJier7pKIyauG1nV38EYNVMvlkbSjQcxkC7jjHNIrIP7j
 7wB4lZP7t0IGOdvLBX61OanqvRkuIV1OMk9AOhN18q8OPfSFU7Imbm4wwrs9EyXi5Nj6
 KKdxeVdmbeTuRKlWKAA6YVvip8qxS4DUWR9/5g+ow5AN22QDtJxQnhCz+BdhIqfswuLl
 pi4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687825401; x=1690417401;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vkR+aXtbcLQFi+Ub06iKUMr1Y/Aix+/+v5uVmme69LI=;
 b=V4RYClhBroOFOEpHNlYwfdtkdBg3zO33ql1PPsBfUnH91cNVU9nv7677Le61ZAQvcI
 abSXQLRcGPs8P6pvIwGDuDPLGOcvrFgpwW5MzwZ4qZLE0+v9tYYlaG+FE1DorlACfDvs
 QmlUqUInoqb1rL51hr3c52MrChgu/h26t4QdSn5jmrKzV5r3Vo7E5ul7IITDJeAK3zw9
 GmQhjYVQ1MlZk30G0PYDy+otHWENZhVSOL7Gz6NplIQ5Ic+XbWpaZZkwxKEUxRAQYnw4
 Jykbp8/LF8PLm36/uew5L0J3cCe7pohixvp39gxnDgNxW4qF/rgw3lMpwkL20Qb7q1dg
 huOw==
X-Gm-Message-State: AC+VfDx7rI7cMYoJNesSTnxAhIR6uUIL9BE5N9jJ6bMatuCpfuTVuObh
 nKKOIVYFDIWdmG5XXZfu4nk=
X-Google-Smtp-Source: ACHHUZ4UyICnYODFBwKfuTn+NoZfMb8XykvSU4do8gTCkVEV0C6MzyB8mK152wYWjcyvzpDPoRNZ3A==
X-Received: by 2002:a17:902:d2c4:b0:1b3:e802:5de6 with SMTP id
 n4-20020a170902d2c400b001b3e8025de6mr7018933plc.29.1687825400809; 
 Mon, 26 Jun 2023 17:23:20 -0700 (PDT)
Received: from localhost (14-200-238-131.tpgi.com.au. [14.200.238.131])
 by smtp.gmail.com with ESMTPSA id
 u12-20020a170902e5cc00b001aae625e422sm3080295plf.37.2023.06.26.17.23.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jun 2023 17:23:20 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Jun 2023 10:23:16 +1000
Message-Id: <CTN062Y7XSEI.8B1BEBDJPZWU@wheely>
Cc: <qemu-devel@nongnu.org>
Subject: Re: [PATCH RFC] icount: don't adjust virtual time backwards after warp
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Paolo Bonzini" <pbonzini@redhat.com>
X-Mailer: aerc 0.15.2
References: <20230625083731.3108-1-npiggin@gmail.com>
 <20230626110847.162190-1-pbonzini@redhat.com>
 <CABgObfanTTyz47UKbYbRqk-6xsntpRpK359vvmh0CuX3+o6k4Q@mail.gmail.com>
In-Reply-To: <CABgObfanTTyz47UKbYbRqk-6xsntpRpK359vvmh0CuX3+o6k4Q@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62c.google.com
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

On Mon Jun 26, 2023 at 9:09 PM AEST, Paolo Bonzini wrote:
> On Mon, Jun 26, 2023 at 1:08=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.co=
m> wrote:
> > Queued, thanks.
>
> Hmm, almost, can you provide the Signed-off-by?

Sure, give me a bit and I'll make up a better changelog and patch.

Thanks,
Nick

