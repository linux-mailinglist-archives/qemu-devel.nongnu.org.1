Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA3E7705B1
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 18:16:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRxRv-0000zs-Bz; Fri, 04 Aug 2023 12:14:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qRxRt-0000zg-Jg
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 12:14:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qRxRs-0008RR-0d
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 12:14:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691165682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GB0oqXsDQiRhHvQJ0tjMic2Yw0h9vQ6Xi7iWybkHFmY=;
 b=ZLzrDYeDN3zEfcEjXAOllLJ0uPyRixMTrEW1GeQBKbpkhe57uVoJthCHodHtTXnJBi4/id
 8u4riiA645CaG6Zha2KuQkdveqj0CtBOlMMtBAPEdXN/P4LKHYDF+HDlouc4Nrno/CejLi
 qsdvgRGKOCwflSBSQYIbRmtk/U/7fBo=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-SNroY7R4PHmLNR2HlHxCQQ-1; Fri, 04 Aug 2023 12:14:41 -0400
X-MC-Unique: SNroY7R4PHmLNR2HlHxCQQ-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4059b5c3dd0so5403991cf.0
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 09:14:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691165680; x=1691770480;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GB0oqXsDQiRhHvQJ0tjMic2Yw0h9vQ6Xi7iWybkHFmY=;
 b=lkYzgilmNQKJeTod6VJpVYvPG6KvfgnhAITDCTrVFwr0pby1Gqdm3CasBSdtEatpYe
 CAMvScWkZnt6bshmpdqwYj3w0ASTUzmecBh8PO6HOuc52NB8G8KpxYVsa2Q8wfh7hhv5
 D85XNnbW4Lua9PCXrpmDvmEvn25KupyNZLKLzoFx27CvL8aQquXMdiHoITqbFVVGlbU9
 FJmFvuCeDjnyF6Hw9g6gC4Zj6WoIUAzVtb+NjT5rWxk1J8n82GQr3SxZ7VP3ZnRrE6uY
 H0IVUoG2bpYt6eCru/fTdDanwSpYQV0yP/Cs0Cj0w1JIXaEp8gxg4Ya4rbmfLPJ25vkB
 svlA==
X-Gm-Message-State: ABy/qLZAp8ggUfsgH4bKM9DBV1EG7ch5hiCuN7Af7EkoxzP7CgDLHccV
 J0GoWFwxQv547PYVwodxe5tdvVsI82qQkRYu7y/h6BBnxTshGpOHjeHHmw8zRZLa9XBQXQCN9uP
 kG11fT1ROEAplMX0=
X-Received: by 2002:a05:622a:1828:b0:3f6:a8e2:127b with SMTP id
 t40-20020a05622a182800b003f6a8e2127bmr24027241qtc.5.1691165680560; 
 Fri, 04 Aug 2023 09:14:40 -0700 (PDT)
X-Google-Smtp-Source: APBJJlExDbJbBDDs3WLniRHOAoAlHnL6Ho1CQpicseHrfI7vkvEoP7AxBU39ADcmd4vXcspc5htKWA==
X-Received: by 2002:a05:622a:1828:b0:3f6:a8e2:127b with SMTP id
 t40-20020a05622a182800b003f6a8e2127bmr24027223qtc.5.1691165680257; 
 Fri, 04 Aug 2023 09:14:40 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 a27-20020ac84d9b000000b00403c1a19a2bsm742911qtw.92.2023.08.04.09.14.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Aug 2023 09:14:39 -0700 (PDT)
Date: Fri, 4 Aug 2023 12:14:36 -0400
From: Peter Xu <peterx@redhat.com>
To: Andrei Gudkov <gudkov.andrei@huawei.com>
Cc: qemu-devel@nongnu.org, yong.huang@smartx.com, quintela@redhat.com,
 leobras@redhat.com, eblake@redhat.com, armbru@redhat.com
Subject: Re: [PATCH v2] migration/calc-dirty-rate: millisecond-granularity
 period
Message-ID: <ZM0j7I98y/cSP9bd@x1n>
References: <8ddb0d40d143f77aab8f602bd494e01e5fa01614.1691161009.git.gudkov.andrei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8ddb0d40d143f77aab8f602bd494e01e5fa01614.1691161009.git.gudkov.andrei@huawei.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Fri, Aug 04, 2023 at 06:03:27PM +0300, Andrei Gudkov wrote:
> Introduces alternative argument calc-time-ms, which is the
> the same as calc-time but accepts millisecond value.
> Millisecond granularity allows to make predictions whether
> migration will succeed or not. To do this, calculate dirty
> rate with calc-time-ms set to max allowed downtime, convert
> measured rate into volume of dirtied memory, and divide by
> network throughput. If the value is lower than max allowed
> downtime, then migration will converge.
> 
> Measurement results for single thread randomly writing to
> a 1/4/24GiB memory region:
> 
> +--------------+-----------------------------------------------+
> | calc-time-ms |                dirty rate MiB/s               |
> |              +----------------+---------------+--------------+
> |              | theoretical    | page-sampling | dirty-bitmap |
> |              | (at 3M wr/sec) |               |              |
> +--------------+----------------+---------------+--------------+
> |                             1GiB                             |
> +--------------+----------------+---------------+--------------+
> |          100 |           6996 |          7100 |         3192 |
> |          200 |           4606 |          4660 |         2655 |
> |          300 |           3305 |          3280 |         2371 |
> |          400 |           2534 |          2525 |         2154 |
> |          500 |           2041 |          2044 |         1871 |
> |          750 |           1365 |          1341 |         1358 |
> |         1000 |           1024 |          1052 |         1025 |
> |         1500 |            683 |           678 |          684 |
> |         2000 |            512 |           507 |          513 |
> +--------------+----------------+---------------+--------------+
> |                             4GiB                             |
> +--------------+----------------+---------------+--------------+
> |          100 |          10232 |          8880 |         4070 |
> |          200 |           8954 |          8049 |         3195 |
> |          300 |           7889 |          7193 |         2881 |
> |          400 |           6996 |          6530 |         2700 |
> |          500 |           6245 |          5772 |         2312 |
> |          750 |           4829 |          4586 |         2465 |
> |         1000 |           3865 |          3780 |         2178 |
> |         1500 |           2694 |          2633 |         2004 |
> |         2000 |           2041 |          2031 |         1789 |
> +--------------+----------------+---------------+--------------+
> |                             24GiB                            |
> +--------------+----------------+---------------+--------------+
> |          100 |          11495 |          8640 |         5597 |
> |          200 |          11226 |          8616 |         3527 |
> |          300 |          10965 |          8386 |         2355 |
> |          400 |          10713 |          8370 |         2179 |
> |          500 |          10469 |          8196 |         2098 |
> |          750 |           9890 |          7885 |         2556 |
> |         1000 |           9354 |          7506 |         2084 |
> |         1500 |           8397 |          6944 |         2075 |
> |         2000 |           7574 |          6402 |         2062 |
> +--------------+----------------+---------------+--------------+
> 
> Theoretical values are computed according to the following formula:
> size * (1 - (1-(4096/size))^(time*wps)) / (time * 2^20),
> where size is in bytes, time is in seconds, and wps is number of
> writes per second.
> 
> Signed-off-by: Andrei Gudkov <gudkov.andrei@huawei.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


