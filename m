Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5029774035
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 19:00:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTQ3x-0005Wg-3z; Tue, 08 Aug 2023 13:00:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qTQ3v-0005Sr-5i
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:00:03 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qTQ3t-0000jj-DQ
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:00:02 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3fe4b95c371so298585e9.1
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 10:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691513999; x=1692118799;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3MFiBipxaUdhi7mNeb+uDR2V5K0J4JyXZkDnkiUfUac=;
 b=WaLvl8+gVoIphjwBdfYsxuA1gKK+tOW228eFrrFASk0iPMIavpxKkkaIM75ohq4/w1
 L2Xbg+7wtmWF/Bknnh0wLgzlWlh+e3jhGenG7VwKoJ+7p638mqcr0BFsrLYv3PQN5acH
 ROIKr1d2gwgXOmOZNmamGE9KAKVa9UsYSGnBmdsOQ6Nq9BQMpdttiQCZlDgaqNafA6d8
 Q9ZT35ylhhm7XPzy9zVSUZRJUDFNQWumgzev+a0fNLc0KCtm84QSYfaCTt/2fbuBQ+Ye
 56Rb1AZs0VKidw7a3PFjN8n0sXqmleFggefQu5tlB+XqL7c0QgBjVQ5gaXNf+GwPr0GP
 P3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691513999; x=1692118799;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3MFiBipxaUdhi7mNeb+uDR2V5K0J4JyXZkDnkiUfUac=;
 b=X2kXX5V+4dMBP55lDeixfHunfypLUpzA/jeVvnb1HBtdqx6JznJycKksN6lcfa6zpF
 YLSmsPyruWFGBgJS8/0k8DYWjX+oCuMYvuJL+4voVJvOkGHxZ5qAdGgz0HJFTrCpyhfD
 7NY3NJbr8F56kw2o1mutZLN/c3SNzAqW/nwJ7p172ukdIi0+36jU5Xn2Zft3ou3gfHCP
 d+M6/vDFfixYl47mjgbnd77IxrR1al8pKFMX7laBXbTtDr3noWUTIT3KRdJqdlM0JBao
 Rq7L1dEJEFWt8WtY1WdQRv1N4NLFP+Qo8aKD8g16BGxFfdGCJPk/6w8f+vG110l6gOMy
 ChXA==
X-Gm-Message-State: AOJu0YxBcM0cW5W27i67UVlZKULIgpjQGdL/ZNdCRmZze6SySQpesjLN
 uTDGPHTxZ22qYEptVfNuzuOCrA==
X-Google-Smtp-Source: AGHT+IGnh8GlVPb6FwI1sIVMlzryt180wIUEVKyR7Rpq6GKgoLLeRK/bXuCb9yT/LhG1+A7j7IhITQ==
X-Received: by 2002:a7b:c3d3:0:b0:3fe:1c10:8d04 with SMTP id
 t19-20020a7bc3d3000000b003fe1c108d04mr309084wmj.19.1691513999540; 
 Tue, 08 Aug 2023 09:59:59 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 k18-20020a7bc412000000b003fbbe41fd78sm14420298wmi.10.2023.08.08.09.59.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 09:59:59 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E373D1FFBB;
 Tue,  8 Aug 2023 17:59:58 +0100 (BST)
References: <20230807163705.9848-1-richard.henderson@linaro.org>
 <20230807163705.9848-2-richard.henderson@linaro.org>
 <87wmy599j3.fsf@linaro.org>
 <ce7a8180-bb8b-0693-c2c0-22fb378239f0@linaro.org>
User-agent: mu4e 1.11.13; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: pbonzini@redhat.com, philmd@linaro.org, laurent@vivier.eu,
 deller@gmx.de, Akihiko Odaki <akihiko.odaki@daynix.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH for-8.1 v10 01/14] linux-user: Adjust task_unmapped_base
 for reserved_va
Date: Tue, 08 Aug 2023 17:59:09 +0100
In-reply-to: <ce7a8180-bb8b-0693-c2c0-22fb378239f0@linaro.org>
Message-ID: <874jl979m9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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


Richard Henderson <richard.henderson@linaro.org> writes:

> On 8/8/23 02:10, Alex Benn=C3=A9e wrote:
>> One thing I'm slightly confused by is the ELF_ET_DYN_BASE can be above
>> this (or sometimes the same). Should the mapping of ELF segments be
>> handled with mmap_next_start? I assume once mmap_next_start meets the
>> mappings for the ELF segments we skip over until we get to more free
>> space after the program code?
>
> ELF_ET_DYN_BASE is a hack imported from the kernel to put separation
> between an ET_DYN main binary and TASK_UNMAPPED_BASE, so that the brk
> can follow the binary and have space to grow.

yeach :-/

>
> All of this is part of the "legacy" memory layout, for which there is a p=
ersonality flag.
>
> For 8.2, I think we should work on implementing the "new" memory
> layout, which places everything top-down.  But most importantly it
> completely separates brk from the binary.

The QEMU brk? The guest will have one emulated for it?

>
>
> r~


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

