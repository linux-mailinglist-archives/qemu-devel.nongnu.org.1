Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF2B7189C2
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 21:01:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4R4B-0002hu-VU; Wed, 31 May 2023 15:01:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1q4R47-0002hQ-AN
 for qemu-devel@nongnu.org; Wed, 31 May 2023 15:00:59 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1q4R45-0000Xt-5K
 for qemu-devel@nongnu.org; Wed, 31 May 2023 15:00:58 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-565ba53f434so71950747b3.3
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 12:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685559656; x=1688151656;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=3UWQhyVgfCSBiKULkjIzbM+8HSmDhmQTBHr9JIGfxB4=;
 b=R8QtC+yVSSBKlnfCzoZOD41TOIk3hAIk9wt6gd2RuBdVh46ks7dYbbhJGzR0aC9Z/j
 wfg1FHN23Rg/Ltd+gnXUAzYNVULbjwtH0sIg2GBEt4iQpmVnXT65HjUdfhX5k5coXsbe
 Sld437JtC6HZJzOsXNDiXI6rowaejfnUnUCK6yI+C84waTuoHsVX73FJnKA/QZWxYyp+
 9hpHRmf4DBgOnLmD/SGHX5xAg8X+NWCJrd8hquF5ncQFXtP1tilB86mIG8T9mJf7eHbY
 52ipWw07wjINwHq7U+VLcUODAZqb01MvSpQrLgB3BYF05e7URFxALdIiSuG7TRQQG1X1
 /GXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685559656; x=1688151656;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3UWQhyVgfCSBiKULkjIzbM+8HSmDhmQTBHr9JIGfxB4=;
 b=KLYT5RJY66dG/bDVLhxCm9e0VjaPnw/dk0XX0yDDnLlMf1pQIonE0w8NyMQy+mKdk7
 iXZJjMUSdfEGOJnwZrR3mfFtFuk8oEK+FXpiWbHlz7O52uaCpQEBh4RYZO179pgB5ucn
 ADdMk16becBJT3hOloUqDp33Zd9EDDiFrJHVwjAusmpRYdAcj/MVXrf+lYa5da8SlX87
 LaEnf9CGD9bv0DmRDi+tkIViYoMqSw6Pc/5EhrT9yv5QtId/8VqWZxphWEkVEEK+40rp
 bcYeVKLPCuIO8q0lIT5prDLMJyFJnJKT9yKlw8pKUfumxHQ35f/qf4NocKbA46Yjh7h5
 ABUw==
X-Gm-Message-State: AC+VfDyzRuXR7y+qJ3I9ngiRxBmwdP8ZqXqdIVKjX402TGyYmC9ElNJV
 jrMW1TxA2hFuXlQHvAGnqOz1P+39v4PoRWD0EXA=
X-Google-Smtp-Source: ACHHUZ6f7nO8G/lsXUFWkgOS3uwO40oEJhm9bIJAkcKKfWK6TLqH0my4B4hlacSTb+M7JwwkdeZVCOcwg2Ka4zqqSTI=
X-Received: by 2002:a0d:dfc8:0:b0:561:18c6:528c with SMTP id
 i191-20020a0ddfc8000000b0056118c6528cmr7663538ywe.30.1685559656199; Wed, 31
 May 2023 12:00:56 -0700 (PDT)
MIME-Version: 1.0
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 31 May 2023 15:00:44 -0400
Message-ID: <CAJSP0QX5XFw81XrHHn9p1pX+1y7tc+xMJLVx9YgRsMCkUwjW7Q@mail.gmail.com>
Subject: Using json: in common.rc's TEST_IMG
To: Hanna Reitz <hreitz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=stefanha@gmail.com; helo=mail-yw1-x112f.google.com
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

Hi Hanna,
I'm adding the io_uring block driver (block/blkio.c) to qemu-iotests
and hit a syntax issue with json:.

In tests/qemu-iotests/common.rc where TEST_IMG_FILE and TEST_IMG are
defined for each IMGPROTO, I'm unable to come up with a TEST_IMG that
works with all test cases. Some test cases want:

  TEST_IMG="json:{\"file.driver\":\"io_uring\",\"file.filename\":\"$TEST_IMG_FILE\"}"

While others want:

  TEST_IMG="json:{\"driver\":\"io_uring\",\"filename\":\"$TEST_IMG_FILE\"}"

It seems to depend on how TEST_IMG is used by the tests.

For example, 001 works with the first version. When I use the second
version it fails with:

  qemu-io: can't open device
json:{"driver":"io_uring","filename":"/home/stefanha/qemu/build/scratch/raw-io_uring-001/t.raw"}:
A block device must be specified for "file"

The opposite is true for 077, which works with the second version but
fails as follows with the first version:

  qemu-io: can't open device
blkdebug::json:{"file.driver":"io_uring","file.filename":"/home/stefanha/qemu/build/scratch/raw-io_uring-077/t.raw"}:
Must specify either driver or file

This only seems to happen with json: because the other protocols use
TEST_IMG=nfs://... and so on without any problems.

Any ideas?

Stefan

