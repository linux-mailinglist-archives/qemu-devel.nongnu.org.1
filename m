Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9957A526C
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 20:57:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiJQD-0006pv-2F; Mon, 18 Sep 2023 14:56:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qiJQA-0006nu-Jj; Mon, 18 Sep 2023 14:56:34 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qiJQ8-0006ic-Ta; Mon, 18 Sep 2023 14:56:34 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-6c21b2c6868so2769183a34.1; 
 Mon, 18 Sep 2023 11:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695063391; x=1695668191; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8rNBwWjs1BfFU7uBI1LYTQ8RE6+eb7bHz7PDVv7ic0I=;
 b=Oq0ukAEyUxTLegbSPQ/uOnkVbGAC7TpPm9KNqZ/CLmESUVDk6U26cz032Vi6M/Gnl1
 H0GWY1MpnBG0/pRbDmy9H8cbH4ySxRDxpX5mJsGKVclDW8OMjwtMr8pQ8BvsKjSYQfNm
 qKv8Akx+Hnm4DFidUv3l38gBHGFK6tSbsg1KU/pTG7Z3kv0lcHLjVcIoy6T17gGJfwZh
 foi4mK9KN6B5qVWL3AigtBAoip50ZcuxfohDO8w4iXwSJyNK+t8Fdn+geLn2MURJnbPz
 inloNqDQqLwq/k6A+5s1AW8UZjYxgxOuvXuzRaKmsYbwWA4xEqdRUyqkFMeBwOdenxCU
 rJdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695063391; x=1695668191;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8rNBwWjs1BfFU7uBI1LYTQ8RE6+eb7bHz7PDVv7ic0I=;
 b=tv/kYfskaxFfHQmEB9yNbGybCM5TC7JpLydYnRFaQYvLJN1PUMQMU4ehPDbd1ACaov
 vOWvag4FvKMF0E+T/5XK0cpYJvMYrifK+2wfDxdFqDdmjpgunHOu1sw59oyEmmdkLz7z
 XmWCTRV52b4IN+Iui6e9spbtTyeeN5zB4LTIWPqmVjoo+1LXA5E5b7KReoBvSsg0sjaz
 cH5VwD51WB4uPn4+Tk00ESrxd/sTK8SpqdEznEkwVZzcpThP3REkwgUky5UwaZuVLiNq
 V0gdOm3nu6zof6BEPHhkrSFhH3vdnOgfLxp/3z31tLIxlEwJLLbGyVvAMyecmyexvaU2
 7LGw==
X-Gm-Message-State: AOJu0YzFNP4ObMs9uL+ZZazgynLgNYpxGV/LFkOckIjd0f0U2vUqFTEu
 u4kZAAq2ZE4Ag56e4xrVW+vuv2vCX1Q9koepolI=
X-Google-Smtp-Source: AGHT+IGidxuwL2JQqY5dr4ePERZSBAPQ8oJ0Mdpc0mpvnSOD8DYyHg51euPZUeNjb8bgrk67+TXTlG03Ls7QERozTnA=
X-Received: by 2002:a9d:6ad6:0:b0:6b9:8feb:8337 with SMTP id
 m22-20020a9d6ad6000000b006b98feb8337mr8632733otq.9.1695063391303; Mon, 18 Sep
 2023 11:56:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230915144344.238596-1-kwolf@redhat.com>
 <CAJSP0QUPOVq5v+7W8E-ruV-Wbg1HYZn2kFWaDzULxSO-3SdEZg@mail.gmail.com>
In-Reply-To: <CAJSP0QUPOVq5v+7W8E-ruV-Wbg1HYZn2kFWaDzULxSO-3SdEZg@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 18 Sep 2023 14:56:19 -0400
Message-ID: <CAJSP0QUYa2+RHeFwztjBrkNs28vqnUVV3rPkNo0+Jx=5ZBfANg@mail.gmail.com>
Subject: Re: [PULL 00/28] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=stefanha@gmail.com; helo=mail-ot1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi Kevin,
I believe that my own commit "block-coroutine-wrapper: use
qemu_get_current_aio_context()" breaks this test. The failure is
non-deterministic (happens about 1 out of 4 runs).

It seems the job hangs and the test times out in vm.run_job('job1', wait=5.0).

I haven't debugged it yet but wanted to share this information to save
some time. Tomorrow I'll investigate further.

Stefan

