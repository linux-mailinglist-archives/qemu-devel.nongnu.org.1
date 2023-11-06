Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F657E27B4
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 15:53:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r00yR-00060o-SE; Mon, 06 Nov 2023 09:53:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1r00yQ-000602-3j
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:53:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1r00yO-0004g1-OY
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:53:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699282384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4TyD+KV5DIAu8ZoRfJs/Z06K0NNeOpY1ihs1Jeax5cM=;
 b=h+IhlWlfWc4kuEnDN+IuzIIj1hxuTp7EnBzzdG7qYEeabgZmo7vp5S0+6XukpgZsonxwPW
 Hr0jVWjMWLvkt1KrZqXxAnNcggpbQ8DDvRwavmLYsHThwtHrZJPaAUN4WY3eIuh+V0WSFj
 TeX721UwiGYF5jCLjg7WEl326v/iVq4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-doHe7ZC3Pd2lzWhxaHLD5A-1; Mon, 06 Nov 2023 09:52:52 -0500
X-MC-Unique: doHe7ZC3Pd2lzWhxaHLD5A-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-32d9602824dso2180757f8f.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 06:52:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699282371; x=1699887171;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4TyD+KV5DIAu8ZoRfJs/Z06K0NNeOpY1ihs1Jeax5cM=;
 b=LJWaykyhVovvSnUC4ZU2PdoJ9Hzjulv5Ncu4H+DRgxsK9c4UgntVvFReh27cgHQ9pu
 fPdZPQeWr1AiNErRUX1NU4K8eGb2I2mYDpD+Pma7Mr5/+3T+T8FvQhLzuMtQ4Qn7R5IA
 nuxcQmlZrSPtmw/TUfriPxoLRhwh7kGO14QQn1sjTDzHMdHlVO/a2HgQg1vp2nPGl+kI
 JrV7gkTkGjpSIO0yGmrS96S+TisnwFbh7PxbegcUxNNMjgupgduBmn8koFQT5+YA5qSQ
 rqRYHQen37Dw87rrS0O0DB2x9Iv/IE5DezE8c1QZCBpGKB3c1HRjER6x+hd/fy1auGTF
 uj6w==
X-Gm-Message-State: AOJu0YxG4jKt32Kyqybyeh2h88xpUfXkQ3MuQkzP/kArHwyBx0F07ysw
 7g2MOdoZcQhWk4ElEh5bBvx66iQAfNIia5AtZn+AWfTfa6tT0+4sARBvBPST3FgOvBQ4I1L/SrM
 epJhheOBe0B87TAM=
X-Received: by 2002:a5d:51c6:0:b0:32d:14c5:643d with SMTP id
 n6-20020a5d51c6000000b0032d14c5643dmr20165501wrv.5.1699282371749; 
 Mon, 06 Nov 2023 06:52:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFHmWwSs03IK9dNqIAz+3AkMvclV+Kw7qY6EmaLamxK/Vwn5aSTHxvwdFMGPqRWXhEAWH3TyA==
X-Received: by 2002:a5d:51c6:0:b0:32d:14c5:643d with SMTP id
 n6-20020a5d51c6000000b0032d14c5643dmr20165485wrv.5.1699282371420; 
 Mon, 06 Nov 2023 06:52:51 -0800 (PST)
Received: from ?IPV6:2003:cf:d718:8590:77de:e1fd:a4df:d080?
 (p200300cfd718859077dee1fda4dfd080.dip0.t-ipconnect.de.
 [2003:cf:d718:8590:77de:e1fd:a4df:d080])
 by smtp.gmail.com with ESMTPSA id
 r7-20020adff107000000b0032db8f7f378sm9754540wro.71.2023.11.06.06.52.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 06:52:50 -0800 (PST)
Message-ID: <516a8b6a-4dfc-405d-9939-0d50968a4694@redhat.com>
Date: Mon, 6 Nov 2023 15:52:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/10] block: Add a thread-pool version of fstat
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Jo=C3=A3o_Silva?=
 <jsilva@suse.de>, Lin Ma <lma@suse.com>, Claudio Fontana <cfontana@suse.de>,
 Dario Faggioli <dfaggioli@suse.com>, Eric Blake <eblake@redhat.com>
References: <20230609201910.12100-1-farosas@suse.de>
 <20230609201910.12100-11-farosas@suse.de>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230609201910.12100-11-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 09.06.23 22:19, Fabiano Rosas wrote:
> From: João Silva <jsilva@suse.de>
>
> The fstat call can take a long time to finish when running over
> NFS. Add a version of it that runs in the thread pool.
>
> Adapt one of its users, raw_co_get_allocated_file size to use the new
> version. That function is called via QMP under the qemu_global_mutex
> so it has a large chance of blocking VCPU threads in case it takes too
> long to finish.
>
> Reviewed-by: Claudio Fontana <cfontana@suse.de>
> Signed-off-by: João Silva <jsilva@suse.de>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>   block/file-posix.c      | 40 +++++++++++++++++++++++++++++++++++++---
>   include/block/raw-aio.h |  4 +++-
>   2 files changed, 40 insertions(+), 4 deletions(-)

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>


