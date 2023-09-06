Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E670793ECB
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 16:29:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdtWT-0000iY-WB; Wed, 06 Sep 2023 10:28:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qdtWS-0000iN-Ny
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 10:28:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qdtWP-0004GC-Bc
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 10:28:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694010524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YKIPd5Ze1GQZkD3aCLCPRJZa+r3tFr8jLkOMZGBfLYo=;
 b=jS6c4eHF+cxOqsrsfLUvqxmh0dDm9ry6s4+42mk8HEb5gCR0PfP8Gl6z2rSdua38vIt8Bg
 Io8ijFOc3S//YbnPQ0jiFljp4DV9P+QodZQG8/i1mETUm2t/cDFkCLM1VB8N07qyVt6mpv
 TUupaUGr+Ten5EGVKtRmxva7W1u67Xk=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-xGNAZ2ILM0eAjW5hThffqA-1; Wed, 06 Sep 2023 10:28:42 -0400
X-MC-Unique: xGNAZ2ILM0eAjW5hThffqA-1
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-44e894b0e06so1066168137.3
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 07:28:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694010520; x=1694615320;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YKIPd5Ze1GQZkD3aCLCPRJZa+r3tFr8jLkOMZGBfLYo=;
 b=QNk8jv3Kkx8iTNkSCz6vMBE62ImGS1U/ePYibj64fs0ArZKu78qu5ILj6xQQ6F0ZPn
 Zu0Vw+hnzQGx2wtlDZFZiLVR5dqpjgioMOAS7QHKt61zRvKbSuyZTWnPlzFGWKBnY+Y7
 laGCcuLf6gmNQ82sDHMqOF0VarNczKJvGPOZoW/jeq717F2K6wL2ZzOdChzwW8zpeAKV
 J07oobrYI3Hryma86V32ErZ/9VnX4xXGAkLwVqoXSDVIU3Dxair3Sl8mZfow8Ye6I0Dk
 X8GalOthi8iRsZx5+sHN4/xxzqgrVBRMJGZPkChnJXYWaPx34QVH8Ka6iFnEPhWIm6YS
 UnvA==
X-Gm-Message-State: AOJu0YymJmm3QBbQ3wUBmtP+3/AoJhMOxAk6d25ESWplMoE8GM5lBLk3
 vu2v3Z+gu9YavTb14rx9PjwBuPFMoGqAg5768kb+Ecd7fp8orMiRlUAVSkv7te9yww56p4+HoIr
 2Td5ZHYG1xg0UMtrzZG/PlMo/UJ0mdgI=
X-Received: by 2002:a67:fc8f:0:b0:44e:9709:c11a with SMTP id
 x15-20020a67fc8f000000b0044e9709c11amr2815024vsp.14.1694010520565; 
 Wed, 06 Sep 2023 07:28:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMZJi+RjuzwBDSUcqKXoqEzPXCM5btHTKXG/VPw9psn7yerr+LMYzR0j6FiGg94Lu6gZP9XcBaw81fc8s8eBA=
X-Received: by 2002:a67:fc8f:0:b0:44e:9709:c11a with SMTP id
 x15-20020a67fc8f000000b0044e9709c11amr2815019vsp.14.1694010520344; Wed, 06
 Sep 2023 07:28:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230906104529.401824-1-pbonzini@redhat.com>
 <npcr4k2cnmjgrr242jls3l3fmt6wucceu4euqcfrlj4ir264pi@urufyyqfbnc5>
In-Reply-To: <npcr4k2cnmjgrr242jls3l3fmt6wucceu4euqcfrlj4ir264pi@urufyyqfbnc5>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 6 Sep 2023 16:28:28 +0200
Message-ID: <CABgObfajZna+kPpuXJh3RP=XXsocCn4F3Sbw8mCz8wpnaBJ84Q@mail.gmail.com>
Subject: Re: [PATCH] subprojects: add wrap file for libblkio
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Sep 6, 2023 at 4:22=E2=80=AFPM Stefano Garzarella <sgarzare@redhat.=
com> wrote:
>        out =3D subprocess.check_output(["cargo", "read-manifest"])
>              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>      File "/usr/lib64/python3.11/subprocess.py", line 466, in check_outpu=
t
>        return run(*popenargs, stdout=3DPIPE, timeout=3Dtimeout, check=3DT=
rue,
>               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>      File "/usr/lib64/python3.11/subprocess.py", line 548, in run
>        with Popen(*popenargs, **kwargs) as process:
>             ^^^^^^^^^^^^^^^^^^^^^^^^^^^
>      File "/usr/lib64/python3.11/subprocess.py", line 1026, in __init__
>        self._execute_child(args, executable, preexec_fn, close_fds,
>      File "/usr/lib64/python3.11/subprocess.py", line 1950, in _execute_c=
hild
>        raise child_exception_type(errno_num, err_msg, err_filename)
>    FileNotFoundError: [Errno 2] No such file or directory: 'cargo'

I think this can be fixed in libblkio instead.  I'll take a look.

Paolo


