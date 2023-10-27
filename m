Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6037D9C7B
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 17:04:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwOMh-0006VT-K9; Fri, 27 Oct 2023 11:03:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qwOMT-0006SK-2v
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 11:02:57 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qwOMN-00061u-GR
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 11:02:56 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-27e0c1222d1so1753745a91.0
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 08:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1698418847; x=1699023647;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:references:cc:to:from:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tVZ3TK8yfiNPw8kqjPbjoFhc82qOk50nQDwJrW5nkAM=;
 b=jfzlAXUXS+CFQVNUoiJcJZhlTFjYxCFWoGA4BYRpHlCmJe2pKpiAFviYaJa3/qES6S
 KaZ/obU22jbeEsz2afikhHh2sPyJQ4JaPd+kx5o4GTyX7WfXAxHyP1Pzvo1TPwM2VN9U
 DEGvOTuvH9OTxxljNztHKViz+LQFCoeelxw7GZmXdaVjj7P2nXyt2S73ON5QqIYiaGol
 e7xB+3xYlVA9LFB8tnnM5Hm0qP+D1YdVXehoX1iw78GHOGCbpbBk+aIxEN7CM+rLkpBG
 lgfJGqCLDVi3PkiCA3m7/N5tIOgWDmfa3c3fOX80vaA9FttPZaXIF1SgZaFWJSCD60DU
 BsSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698418847; x=1699023647;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tVZ3TK8yfiNPw8kqjPbjoFhc82qOk50nQDwJrW5nkAM=;
 b=YP+8FMj1YuK4d3MMNEBAw1krdh0saNRd0l1grscWvkTQ+DiFWo9UwO92pmeQzcS8mw
 xC/k9cXIIVo28BII/yBEjuJ/av20VQvWO0m94A7FY6Fd5gXAx5esprqSblkTnInz5Mb1
 ad8oTBundqt0zaZXZWMx9yV8L5mtz3WNa9qLmNaTmwQkOiA9vzXaVNnXqMGMmBk2eJti
 1+i0hiTlkGDI6hnXBMzwc/FORK96nZeNaEaFYWmUS6jpR6/ZzwtKJLlKlIFxHRQeC2Ns
 wyACFEBNmgQRtyWWAhjw/L9ME/yTKQZbuM4zpt9j3RGnel1hYHJYV2ZO4tGJDr9ggzKd
 mQhQ==
X-Gm-Message-State: AOJu0YxcIQLQYFcNid2cN6OKOZU1usnMhWGjdbvbYgKp5OP/5KNLZJqF
 QaveouEVYweCU3s9tixpFN2se636b9gbSl9flx/EXg==
X-Google-Smtp-Source: AGHT+IF3d8a3Nt2et1cuzoOn/Q9osQBhpbIrRMcHXB9yg3jW+3Ir6JDWnPo0gpo4H5DgMU8s6ta7Ww==
X-Received: by 2002:a17:90a:1a10:b0:27c:e826:5038 with SMTP id
 16-20020a17090a1a1000b0027ce8265038mr2833526pjk.14.1698418846816; 
 Fri, 27 Oct 2023 08:00:46 -0700 (PDT)
Received: from [26.26.26.1] ([45.158.180.111])
 by smtp.gmail.com with ESMTPSA id
 z9-20020a17090a608900b0027d0de51454sm2578304pji.19.2023.10.27.08.00.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Oct 2023 08:00:46 -0700 (PDT)
Message-ID: <103c0b7e-b2e6-feab-1b77-0340640ddf34@smartx.com>
Date: Fri, 27 Oct 2023 23:00:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [v2 4/6] tests/migration: Introduce dirty-ring-size option into
 guestperf
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
References: <cover.1697815117.git.yong.huang@smartx.com>
 <bd9f195883fb5081f67f680bd2972a4b0a5b3520.1697815117.git.yong.huang@smartx.com>
 <CAK9dgmYqBBFkLNWNsH4th7znTAOiGiYMg-SzNTWVPk=csZw_jw@mail.gmail.com>
In-Reply-To: <CAK9dgmYqBBFkLNWNsH4th7znTAOiGiYMg-SzNTWVPk=csZw_jw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::1034;
 envelope-from=yong.huang@smartx.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, NICE_REPLY_A=-3.339, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

ping1

在 2023/10/23 10:03, Yong Huang 写道:
> ping.
>
> Regarding the performance of the live migration, Guestperf could 
> provide us
> with a clear response. IMHO, by just adding a few metrics, it might be 
> developed
> into a more user-friendly metrics system in the future.
>
> We may still enrich it prior to that.
>
> On Fri, Oct 20, 2023 at 11:24 PM Hyman Huang <yong.huang@smartx.com> 
> wrote:
>
>     Dirty ring size configuration is not supported by guestperf tool.
>
>     Introduce dirty-ring-size (ranges in [1024, 65536]) option so
>     developers can play with dirty-ring and dirty-limit feature easier.
>
>     To set dirty ring size with 4096 during migration test:
>     $ ./tests/migration/guestperf.py --dirty-ring-size 4096 xxx
>
>     Signed-off-by: Hyman Huang <yong.huang@smartx.com>
>     ---
>      tests/migration/guestperf/engine.py   | 6 +++++-
>      tests/migration/guestperf/hardware.py | 8 ++++++--
>      tests/migration/guestperf/shell.py    | 6 +++++-
>      3 files changed, 16 insertions(+), 4 deletions(-)
>
>     diff --git a/tests/migration/guestperf/engine.py
>     b/tests/migration/guestperf/engine.py
>     index da96ca034a..aabf6de4d9 100644
>     --- a/tests/migration/guestperf/engine.py
>     +++ b/tests/migration/guestperf/engine.py
>     @@ -325,7 +325,6 @@ def _get_common_args(self, hardware,
>     tunnelled=False):
>                  cmdline = "'" + cmdline + "'"
>
>              argv = [
>     -            "-accel", "kvm",
>                  "-cpu", "host",
>                  "-kernel", self._kernel,
>                  "-initrd", self._initrd,
>     @@ -333,6 +332,11 @@ def _get_common_args(self, hardware,
>     tunnelled=False):
>                  "-m", str((hardware._mem * 1024) + 512),
>                  "-smp", str(hardware._cpus),
>              ]
>     +        if hardware._dirty_ring_size:
>     +            argv.extend(["-accel", "kvm,dirty-ring-size=%s" %
>     +                         hardware._dirty_ring_size])
>     +        else:
>     +            argv.extend(["-accel", "kvm"])
>
>              argv.extend(self._get_qemu_serial_args())
>
>     diff --git a/tests/migration/guestperf/hardware.py
>     b/tests/migration/guestperf/hardware.py
>     index 3145785ffd..f779cc050b 100644
>     --- a/tests/migration/guestperf/hardware.py
>     +++ b/tests/migration/guestperf/hardware.py
>     @@ -23,7 +23,8 @@ def __init__(self, cpus=1, mem=1,
>                       src_cpu_bind=None, src_mem_bind=None,
>                       dst_cpu_bind=None, dst_mem_bind=None,
>                       prealloc_pages = False,
>     -                 huge_pages=False, locked_pages=False):
>     +                 huge_pages=False, locked_pages=False,
>     +                 dirty_ring_size=0):
>              self._cpus = cpus
>              self._mem = mem # GiB
>              self._src_mem_bind = src_mem_bind # List of NUMA nodes
>     @@ -33,6 +34,7 @@ def __init__(self, cpus=1, mem=1,
>              self._prealloc_pages = prealloc_pages
>              self._huge_pages = huge_pages
>              self._locked_pages = locked_pages
>     +        self._dirty_ring_size = dirty_ring_size
>
>
>          def serialize(self):
>     @@ -46,6 +48,7 @@ def serialize(self):
>                  "prealloc_pages": self._prealloc_pages,
>                  "huge_pages": self._huge_pages,
>                  "locked_pages": self._locked_pages,
>     +            "dirty_ring_size": self._dirty_ring_size,
>              }
>
>          @classmethod
>     @@ -59,4 +62,5 @@ def deserialize(cls, data):
>                  data["dst_mem_bind"],
>                  data["prealloc_pages"],
>                  data["huge_pages"],
>     -            data["locked_pages"])
>     +            data["locked_pages"],
>     +            data["dirty_ring_size"])
>     diff --git a/tests/migration/guestperf/shell.py
>     b/tests/migration/guestperf/shell.py
>     index 8a809e3dda..7d6b8cd7cf 100644
>     --- a/tests/migration/guestperf/shell.py
>     +++ b/tests/migration/guestperf/shell.py
>     @@ -60,6 +60,8 @@ def __init__(self):
>              parser.add_argument("--prealloc-pages",
>     dest="prealloc_pages", default=False)
>              parser.add_argument("--huge-pages", dest="huge_pages",
>     default=False)
>              parser.add_argument("--locked-pages",
>     dest="locked_pages", default=False)
>     +        parser.add_argument("--dirty-ring-size",
>     dest="dirty_ring_size",
>     +                            default=0, type=int)
>
>              self._parser = parser
>
>     @@ -89,7 +91,9 @@ def split_map(value):
>
>                              locked_pages=args.locked_pages,
>                              huge_pages=args.huge_pages,
>     -                        prealloc_pages=args.prealloc_pages)
>     +                        prealloc_pages=args.prealloc_pages,
>     +
>     +                        dirty_ring_size=args.dirty_ring_size)
>
>
>      class Shell(BaseShell):
>     -- 
>     2.39.1
>
>
>
> -- 
> Best regards

