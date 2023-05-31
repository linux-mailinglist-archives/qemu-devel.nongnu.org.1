Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C20C97189E4
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 21:11:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4RCo-0003tu-Qy; Wed, 31 May 2023 15:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1q4RCn-0003sE-F5
 for qemu-devel@nongnu.org; Wed, 31 May 2023 15:09:57 -0400
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1q4RCl-0002KM-IE
 for qemu-devel@nongnu.org; Wed, 31 May 2023 15:09:56 -0400
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-bad102ce9eeso8042124276.0
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 12:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685560194; x=1688152194;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4g/z0zvm40xiWWdnaIIfRxdR1l3TGi/lLalXBrlj+wY=;
 b=SpfIqo7Zche7IJs0Meh4KZgQxqyH1bFG4GHqxQwiZLU6tYamlSXUKxvXevfceFxhzm
 zTr8ONOG9UoDStF1ydr7DvSeJQO52GJHQQBk8f8bz4E7gGo7/4aR1Q/4tf373uCAOJ50
 BCDYdy0STCAq52kTtHOQoarXkNUdTJzMCdd6GHkEvdIHXLbSZ2i5doqo9xADE/lAv27z
 ae7U7kQx8E99rJqxHsWYps50SG597HD2Fads2CnU/PtcfDMt1fAvss11ahhJPv76jilp
 wFMx9TCXQWfA/ookPzbsz1d0UthFEqrSO6Xd27Yxw+yIvXrNW/pBr/u7ozN+RRo3/8Et
 vOjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685560194; x=1688152194;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4g/z0zvm40xiWWdnaIIfRxdR1l3TGi/lLalXBrlj+wY=;
 b=inmmki034nR3fRkGwtmrtUseDys9HZ28EtLPj3KwqZWAcEuF8yi6+7CVQ1u89D11lK
 fFFslzgXktWewACKKrhHRnY5OK12QAdLirGSruFmihmmTm2wfIusQ6HgV8x8I74FH7Yx
 Z5kLxei1UJQegUPOyBlupu5aGzk3AxYISAh45f53eT2Zfvi249EbJg/OsUra1DdmJ/Gb
 /Wzdbi2fzrQeHbLL52XWhY1WfqY8mSfYHfqPd4R0ha50YcNzn+5FzbYZS2sz3edlfems
 hn7QklQ0WFTfzUHqTUt4dfEUnAjLXIWZK3oKvO3WzCKR19TLD4COOequBgyCilsxK6Lz
 9pKw==
X-Gm-Message-State: AC+VfDwiTrqsYwlbcaiXUoDYvWZWZMiSVaJUErF6kmI4CL1h6VaRLOxC
 PomJol6L9RgJmYMtL5FFjelZp2anHEYCXPZTy3I=
X-Google-Smtp-Source: ACHHUZ5dgGiNwsc/fPjCukn8K+UmwGCtI0XiX0FUrNlNYal9dVc+S32b+8je8jGSi1XCTQ3DcjZi+ZyP1QQEiEKZnyk=
X-Received: by 2002:a25:3254:0:b0:bad:125f:9156 with SMTP id
 y81-20020a253254000000b00bad125f9156mr7115371yby.35.1685560194232; Wed, 31
 May 2023 12:09:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAJSP0QX5XFw81XrHHn9p1pX+1y7tc+xMJLVx9YgRsMCkUwjW7Q@mail.gmail.com>
In-Reply-To: <CAJSP0QX5XFw81XrHHn9p1pX+1y7tc+xMJLVx9YgRsMCkUwjW7Q@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 31 May 2023 15:09:42 -0400
Message-ID: <CAJSP0QXpxyVPXieK9W4h+NxK4KNkOvnFD4KvuDMcZ9PLx9Sfvw@mail.gmail.com>
Subject: Re: Using json: in common.rc's TEST_IMG
To: Hanna Reitz <hreitz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b29;
 envelope-from=stefanha@gmail.com; helo=mail-yb1-xb29.google.com
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

Another issue is that 145 uses $TEST_IMG as follows:

  SYSEMU_DRIVE_ARG=if=none,file="$TEST_IMG",driver=$IMGFMT

That doesn't work when json: contains a comma, since commas need to be
doubled up to escape them. This fails:

  $ qemu-system-x86_64 -drive
'if=none,file=json:{"driver":"io_uring","filename":"test.img"}'
  qemu-system-x86_64: -drive
if=none,file=json:{"driver":"io_uring","filename":"test.img"}:
warning: short-form boolean option '"filename":"test.img"}' deprecated
  Please use "filename":"test.img"}=on instead

This works:

  qemu-system-x86_64 -drive
'if=none,file=json:{"driver":"io_uring",,"filename":"test.img"}'

Maybe it's simply not possible to use TEST_IMG=json: in qemu-iotests?

The alternative is to always set IMGOPTSSYNTAX=true and then find the
test cases that fail because they contain non-IMGOPTSSYNTAX commands.

Stefan

