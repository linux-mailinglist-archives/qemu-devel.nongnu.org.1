Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6507B090F
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 17:40:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlWd5-0006bv-5C; Wed, 27 Sep 2023 11:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qlWd2-0006bO-Vf
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 11:39:09 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qlWd1-0007PR-K5
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 11:39:08 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6beff322a97so6594345a34.3
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 08:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695829146; x=1696433946; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5iFVsj33IbwLUWUudE9sEOXRk4bJTW29cOqWrdEDUic=;
 b=ElwtcnIEMz/uaRCoYJZ0N+RX7JJg6zkMcbGmjGoquxubR/iAfy3GOhd+57gW1CSF0W
 gRx+1Q9/IrYag/0s0we0RxZHlP7yKP8Eqi09tgf5p5IEUmftcGUtoGO8Sb+dWuNOyxFr
 gBxw4VbCI3CBwiwk/UYq00Pyicp6oF8cZ8HQCjsljkgaoyf5fvPee/mAKB4CZsiZrNKY
 LlFTbJw9fNQDRvy5Xjr8eJOqwSzovtpkVv5E6FKQnHa05o2usVIkTGX0FXM3jHSEMNMA
 mNYVDrrvrVYMHETf0kn5JEWOMmSZoGrz2s3Xf0Tp9OROKe1NJk4b2kpMPiuPht52uOSt
 5w1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695829146; x=1696433946;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5iFVsj33IbwLUWUudE9sEOXRk4bJTW29cOqWrdEDUic=;
 b=pY4CNJVK6JhZQkB016tkMkAGfbpDmxoWApeoNVUboeMTRVopdmfAgy32jYUMyhZSp+
 97Bn83ew013bT9mvgy6c9y7iv6OPnt4v4D9qVdGAcLg9lAj7fPihTGQc2LFSvWkFuBFj
 dn10YSuU9WhP9ixrq3hQyDoyMOeF3p0xBygldUt1886/PqeSzXiez7j/UAMoZniJd2Qt
 u6HEdmkMbK0uDt1Lum3/MUkiFmcZU/zhYnCfkKNZoocpGeVxXpYA5u5eu2npCyag/GaC
 M73jN0Ein5YaFOSFPNmmnFBNzzgU7V2HR1PhS//Ci39LnqxBDg42TZD77u5LLwfXtyJI
 5FDA==
X-Gm-Message-State: AOJu0YzrwM3J7bX9ygqYz93ExRtTx3GiXgpWxJA5JLeHAs9xiHb0Fbqc
 FOJymlsh7nGKmlaLo5AvOD714X8MN9Q+hB+Gpp0=
X-Google-Smtp-Source: AGHT+IES65jUT7IOAH73zdCpXG37kElged08v9aoiKwu1Veo9BRGOgVNQ92XruFHfenvwV6467PjBy46ABuZ5tTR2SA=
X-Received: by 2002:a9d:7dd1:0:b0:6b8:6c1d:d83d with SMTP id
 k17-20020a9d7dd1000000b006b86c1dd83dmr2561009otn.26.1695829146187; Wed, 27
 Sep 2023 08:39:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230927140016.2317404-1-i.maximets@ovn.org>
In-Reply-To: <20230927140016.2317404-1-i.maximets@ovn.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 27 Sep 2023 11:38:54 -0400
Message-ID: <CAJSP0QVf_sPbHwq0Vq6cavrrSBXkbAt7-GrxdVzmv073DpG+Bw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] virtio: clean up of
 virtqueue_split_read_next_desc()
To: Ilya Maximets <i.maximets@ovn.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, 
 Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=stefanha@gmail.com; helo=mail-ot1-x329.google.com
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

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

On Wed, 27 Sept 2023 at 10:00, Ilya Maximets <i.maximets@ovn.org> wrote:
>
>
> Version 2:
>   - Converted into a patch set adding a new patch that removes the
>     'next' argument.  [Stefan]
>   - Completely removing the barrier instead of changing into compiler
>     barrier.  [Stefan]
>
>
> Ilya Maximets (2):
>   virtio: remove unnecessary thread fence while reading next descriptor
>   virtio: remove unused next argument from
>     virtqueue_split_read_next_desc()
>
>  hw/virtio/virtio.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
>
> --
> 2.41.0
>
>

