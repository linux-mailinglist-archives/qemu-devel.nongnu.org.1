Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56CB2732A93
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 10:54:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qA5Co-0006Qv-Ts; Fri, 16 Jun 2023 04:53:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xuchuangxclwt@bytedance.com>)
 id 1qA5Cm-0006PF-MB
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 04:53:16 -0400
Received: from mail-qv1-xf30.google.com ([2607:f8b0:4864:20::f30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xuchuangxclwt@bytedance.com>)
 id 1qA5Ck-0006Zf-Bj
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 04:53:16 -0400
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-62ddb103e1dso5109166d6.2
 for <qemu-devel@nongnu.org>; Fri, 16 Jun 2023 01:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1686905590; x=1689497590;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :references:mime-version:user-agent:in-reply-to:from:to:cc:subject
 :date:message-id:reply-to;
 bh=N1ONw5aelAwc4TnCV1dZroMSgrwCi/mYyw6fVtmBmrg=;
 b=O55Ou7ZOdSSkcip57tY2ImEalGX3Xzl2fmzGc2WzS3InNrx9NqCkot4+YPtdXm3Gbh
 DQiH90C0KwuoUnPYHomMn9lwv4qLHDtKA41my/19Llm82ucG5IpudaN8+CicK4oA2F8U
 lQzKemN0Vu2VdG+DOp8wuoITlOcTjqPjoa5zBuQkpzEH+lu6GtuYrvWVlXEonN1QJeHT
 KerDwW5eB5fJ6/gmzCVF9qULtatdAx9SpUSe5NWcpH+1OuQdys3lfBdKTYzExu4kvNhe
 8c0mp8Ql4QbqgBefQ4XZS1qHNIwmAiRWrHqs/G6PCSpAYsTriUsmxvsF9igHEqNKojDu
 ArVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686905590; x=1689497590;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :references:mime-version:user-agent:in-reply-to:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=N1ONw5aelAwc4TnCV1dZroMSgrwCi/mYyw6fVtmBmrg=;
 b=TxG47IDOoHLkZnnxX10XEwc6jvF7SEn0AUKugGrVDhKi8SQD1r2Sl3ayCUeCrjSWia
 IwB9idFvF42xJh/wd6sEA69ey3h5b0F9Z3tVRbdpBzVhoxl3qYXUg48T9Ci9xmHMgRoi
 TUNFbZ84oN3Tl+JycsPpS0iBq2EUKqTW0tXyFB2dkH3OWOj2KcaZJsB5FsIt1YyTUpCV
 kxp5mqOFHc2z1ShAcywMLJuA4ydrvDUQ24CAiHfI8+mBNwm2577LkF/Rkr90qLj27+TE
 6iMDNoZbm+kAljA1ZWboJqQMNA4UHEfRJ85s/jOEPmsFVa+A8LcQSsXCYWR/cBH553q1
 ZcDQ==
X-Gm-Message-State: AC+VfDy4aqCUHi4/SNBNd8FkiTddiYtDeQWq3c+G+GgaDk3CZVPcveH4
 b+3hqoDiQwZJKIcPBJA2XVycUjRcIW/kgAikjVVsJQ==
X-Google-Smtp-Source: ACHHUZ6M9oY6iHLR2WN9zLR4kjA9zl9MgAspogu4Ap462rMZ/n6pNnblPyWirnHFsFFpGQWwSTldzyDdG2wgcSJE/8Y=
X-Received: by 2002:a05:6214:411c:b0:62d:eae2:a441 with SMTP id
 kc28-20020a056214411c00b0062deae2a441mr1275773qvb.64.1686905590699; Fri, 16
 Jun 2023 01:53:10 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST; 
 Fri, 16 Jun 2023 03:53:10 -0500
In-Reply-To: <20230130080956.3047-5-quintela@redhat.com>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Mime-Version: 1.0
References: <20230130080956.3047-1-quintela@redhat.com>
 <20230130080956.3047-5-quintela@redhat.com>
From: Chuang Xu <xuchuangxclwt@bytedance.com>
Date: Fri, 16 Jun 2023 03:53:10 -0500
Message-ID: <CALophutb+J2Qqa-msbY_aW+sz-OPW-XoQQLfCVfEXLfcaWa8xQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/11] multifd: Count the number of bytes sent correctly
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::f30;
 envelope-from=xuchuangxclwt@bytedance.com; helo=mail-qv1-xf30.google.com
X-Spam_score_int: 6
X-Spam_score: 0.6
X-Spam_bar: /
X-Spam_report: (0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_MUA_MOZILLA=2.309,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001,
 NICE_REPLY_A=-0.098, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Hi,Juan,

On 2023/1/30 =E4=B8=8B=E5=8D=884:09, Juan Quintela wrote:
> Current code asumes that all pages are whole.  That is not true for
> example for compression already.  Fix it for creating a new field
> ->sent_bytes that includes it.
>
> All ram_counters are used only from the migration thread, so we have
> two options:
> - put a mutex and fill everything when we sent it (not only
>    ram_counters, also qemu_file->xfer_bytes).
> - Create a local variable that implements how much has been sent
>    through each channel.  And when we push another packet, we "add" the
>    previous stats.
>
> I choose two due to less changes overall.  On the previous code we
> increase transferred and then we sent.  Current code goes the other
> way around.  It sents the data, and after the fact, it updates the
> counters.  Notice that each channel can have a maximum of half a
> megabyte of data without counting, so it is not very important.
>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>   migration/multifd.h | 2 ++
>   migration/multifd.c | 6 ++++--
>   2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/migration/multifd.h b/migration/multifd.h
> index e2802a9ce2..36f899c56f 100644
> --- a/migration/multifd.h
> +++ b/migration/multifd.h
> @@ -102,6 +102,8 @@ typedef struct {
>       uint32_t flags;
>       /* global number of generated multifd packets */
>       uint64_t packet_num;
> +    /* How many bytes have we sent on the last packet */
> +    uint64_t sent_bytes;
>       /* thread has work to do */
>       int pending_job;
>       /* array of pages to sent.
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 61cafe4c76..cd26b2fda9 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -394,7 +394,6 @@ static int multifd_send_pages(QEMUFile *f)
>       static int next_channel;
>       MultiFDSendParams *p =3D NULL; /* make happy gcc */
>       MultiFDPages_t *pages =3D multifd_send_state->pages;
> -    uint64_t transferred;
>
>       if (qatomic_read(&multifd_send_state->exiting)) {
>           return -1;
> @@ -429,7 +428,8 @@ static int multifd_send_pages(QEMUFile *f)
>       p->packet_num =3D multifd_send_state->packet_num++;
>       multifd_send_state->pages =3D p->pages;
>       p->pages =3D pages;
> -    transferred =3D ((uint64_t) pages->num) * p->page_size + p->packet_l=
en;
> +    uint64_t transferred =3D p->sent_bytes;
> +    p->sent_bytes =3D 0;
>       qemu_file_acct_rate_limit(f, transferred);
>       qemu_mutex_unlock(&p->mutex);
>       stat64_add(&ram_atomic_counters.multifd_bytes, transferred);
> @@ -719,6 +719,8 @@ static void *multifd_send_thread(void *opaque)
>               }
>
>               qemu_mutex_lock(&p->mutex);
> +            p->sent_bytes +=3D p->packet_len;
> +            p->sent_bytes +=3D p->next_packet_size;

Consider a scenario where some normal pages are transmitted in the first ro=
und,
followed by several consecutive rounds of zero pages. When zero pages
are transmitted,
next_packet_size of first round is still incorrectly added to
sent_bytes. If we set a rate
limiting for dirty page transmission, the transmission performance of
multi zero check
will degrade.

Maybe we should set next_packet_size to 0 in multifd_send_pages()?

>               p->pending_job--;
>               qemu_mutex_unlock(&p->mutex);
>

