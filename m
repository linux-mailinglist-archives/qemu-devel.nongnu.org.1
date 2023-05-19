Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5231C709F69
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 20:50:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q05A3-000368-Py; Fri, 19 May 2023 14:49:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q05A2-00035k-2d
 for qemu-devel@nongnu.org; Fri, 19 May 2023 14:49:06 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q05A0-0006nw-5l
 for qemu-devel@nongnu.org; Fri, 19 May 2023 14:49:05 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-64d2ca9ef0cso1131580b3a.1
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 11:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684522142; x=1687114142;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9Q7makMAKzS3YovegkFy3+ThdHrQyiRiVnKHQTc+7Fs=;
 b=ySpah6fPLfhT+VUQWR2IdyYGlAIFk3LFEQOrZjxIiiDM520+QX05SDFUXVRlWYd6lj
 IyAJV/Ok0dXauNPTMAe5K+YZ9cRGRB01QSN9LqWWQ+m/mc/TeHeFROavN9ZmdVEPyB5h
 b6Lk5T5ZUz00b+VJgLCjESZYwoM94q6sFElN4+yMSofoXB16r5R+WJdS+zV0DnNK8cPW
 z1Mis56KPywEfEuovUTGTjV9kQcBvRHNIrNrhiBGmup0k8qTnCfHIyUtSLJBL3jOzoLR
 x7AMx2LBdKhPwKKYMzEKeQxZa0YvCAU7IwiaM/ICq3oWl7Iv5roL9tbaDdc0EMIAZAqQ
 zx7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684522142; x=1687114142;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9Q7makMAKzS3YovegkFy3+ThdHrQyiRiVnKHQTc+7Fs=;
 b=b25pqj+tr6xxgBLzZ6t4On8SGIH9/ifBeVsY5mWXeiGuiJ4jCwzgUfTMq4WIKdq7SU
 /KRVrdH3UO/iNZxelevMXUz0tIWZomgLJ6h00rz3NBQvlhkGEF2iN0hpL1DdAjbjiuiK
 RzMW04QMDk2QIwtxey4Y0fXHpphqtQweGjgXoPlgOrP8jb2eANyUI2UTUQaGVZ2WuuZr
 09ADCGEPIlWCzdsS4BUxENMt6pCkHIjJAtuQ1a+ZbysRk67oiC0eLMq63FGCtcZqfv5r
 uktph4eiD429mlR7EP+GMGZNXNkhth7DSRlKzxdbdI42eV6xCXc4TaAoeJnULQVnnSzi
 Gf2Q==
X-Gm-Message-State: AC+VfDwpDpVvxgNNl7l2VmSsEtBfdNnyRBVA/4vNA9sicvNNAhH2UeXb
 cyyiBE/RSlOhbgbLMgkN9YvoZA==
X-Google-Smtp-Source: ACHHUZ7X3KnzL4Zf9kVM34/GhFxV1uP3uVkfOQEqxigInlZzFskvbdVQ+EehRi8h91Jf0ciISNlDjA==
X-Received: by 2002:a05:6a20:4287:b0:f6:55c:5371 with SMTP id
 o7-20020a056a20428700b000f6055c5371mr3544070pzj.49.1684522142197; 
 Fri, 19 May 2023 11:49:02 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:686f:d1bb:8fc4:dc38?
 ([2602:ae:1598:4c01:686f:d1bb:8fc4:dc38])
 by smtp.gmail.com with ESMTPSA id
 w12-20020a65410c000000b0052c22778e64sm35351pgp.66.2023.05.19.11.49.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 May 2023 11:49:01 -0700 (PDT)
Message-ID: <c74f18d7-47a4-5251-85c2-a9981e9603bf@linaro.org>
Date: Fri, 19 May 2023 11:48:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL v3 00/21] Block layer patches
Content-Language: en-US
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20230519171806.435109-1-kwolf@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230519171806.435109-1-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.527,
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

On 5/19/23 10:18, Kevin Wolf wrote:
> The following changes since commit d009607d08d22f91ca399b72828c6693855e7325:
> 
>    Revert "arm/kvm: add support for MTE" (2023-05-19 08:01:15 -0700)
> 
> are available in the Git repository at:
> 
>    https://repo.or.cz/qemu/kevin.git tags/for-upstream
> 
> for you to fetch changes up to 95fdd8db61848d31fde1d9b32da7f3f76babfa25:
> 
>    iotests: Test commit with iothreads and ongoing I/O (2023-05-19 19:16:53 +0200)
> 
> ----------------------------------------------------------------
> Block layer patches
> 
> - qcow2 spec: Rename "zlib" compression to "deflate"
> - Honour graph read lock even in the main thread + prerequisite fixes
> - aio-posix: do not nest poll handlers (fixes infinite recursion)
> - Refactor QMP blockdev transactions
> - graph-lock: Disable locking for now
> - iotests/245: Check if 'compress' driver is available
> 
> ----------------------------------------------------------------
> Akihiro Suda (1):
>        docs/interop/qcow2.txt: fix description about "zlib" clusters
> 
> Kevin Wolf (12):
>        block: Call .bdrv_co_create(_opts) unlocked
>        block/export: Fix null pointer dereference in error path
>        qcow2: Unlock the graph in qcow2_do_open() where necessary
>        qemu-img: Take graph lock more selectively
>        test-bdrv-drain: Take graph lock more selectively
>        test-bdrv-drain: Call bdrv_co_unref() in coroutine context
>        blockjob: Adhere to rate limit even when reentered early
>        graph-lock: Honour read locks even in the main thread
>        iotests/245: Check if 'compress' driver is available
>        graph-lock: Disable locking for now
>        nbd/server: Fix drained_poll to wake coroutine in right AioContext
>        iotests: Test commit with iothreads and ongoing I/O
> 
> Stefan Hajnoczi (2):
>        aio-posix: do not nest poll handlers
>        tested: add test for nested aio_poll() in poll handlers
> 
> Vladimir Sementsov-Ogievskiy (6):
>        blockdev: refactor transaction to use Transaction API
>        blockdev: transactions: rename some things
>        blockdev: qmp_transaction: refactor loop to classic for
>        blockdev: transaction: refactor handling transaction properties
>        blockdev: use state.bitmap in block-dirty-bitmap-add action
>        blockdev: qmp_transaction: drop extra generic layer

Test failure:

https://gitlab.com/qemu-project/qemu/-/jobs/4317480370#L3347

194              fail       [18:42:03] [18:42:05]   1.2s                 output mismatch 
(see /builds/qemu-project/qemu/build/tests/qemu-iotests/scratch/raw-file-194/194.out.bad)
--- /builds/qemu-project/qemu/tests/qemu-iotests/194.out
+++ /builds/qemu-project/qemu/build/tests/qemu-iotests/scratch/raw-file-194/194.out.bad
@@ -14,7 +14,6 @@
  {"return": {}}
  {"data": {"status": "setup"}, "event": "MIGRATION", "timestamp": {"microseconds": 
"USECS", "seconds": "SECS"}}
  {"data": {"status": "active"}, "event": "MIGRATION", "timestamp": {"microseconds": 
"USECS", "seconds": "SECS"}}
-{"data": {"status": "postcopy-active"}, "event": "MIGRATION", "timestamp": 
{"microseconds": "USECS", "seconds": "SECS"}}
  {"data": {"status": "completed"}, "event": "MIGRATION", "timestamp": {"microseconds": 
"USECS", "seconds": "SECS"}}
  Gracefully ending the `drive-mirror` job on source...


r~

