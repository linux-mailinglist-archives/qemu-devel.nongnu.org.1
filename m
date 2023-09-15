Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F337A1D54
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 13:21:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh6sq-0006bq-GS; Fri, 15 Sep 2023 07:21:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qh6sn-0006be-P0
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 07:21:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qh6sj-0007Fz-S9
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 07:21:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694776864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SuK9/466IRkOOTjyBDluAgz9uNgmFaySnLSKDb/XSIA=;
 b=dYeuflM4zUiP3B+ItKEZBMIbZwD5F4gQw+DsiXwUkaE0C8tK4uOYGMlhS3uYYoFAK8pQAr
 JKgKE5nCv2jh4wr/TiTm8hfVBbLjCJ0a5s9saN6Q25IazZuD7s+zJP4JZChomNvCkvG7wE
 Odnb2MWa00EG+YxBzIVLXJKbRk+48jg=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-DdbLIlGbO8qGINdRZvyqIQ-1; Fri, 15 Sep 2023 07:21:03 -0400
X-MC-Unique: DdbLIlGbO8qGINdRZvyqIQ-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2bfbdcd728cso25081041fa.2
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 04:21:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694776861; x=1695381661;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SuK9/466IRkOOTjyBDluAgz9uNgmFaySnLSKDb/XSIA=;
 b=p2mfeO+T6+6JRDd4A726WMjXOxnfEcvwX0sM8ZM+jg0LMfWN5c3RsMrN35yIn+cAPx
 L24/lF7kxlwd9iwhRGENVuMGbmSXdK5hKO8H1jt8GFvj8Fu3zrPgkYEDLeiuF2VCqZrm
 B91dtCoOJgdZSZ1eFP7Ij4/mbIU102BYTbOvc/VM5rd/u3G4IHwddWq2VqgG2rlqkpnI
 hH62542jl5dvdna8HJ1nYTtzskuY56hd28xNbNM7C72Oj+TFjypZESDniht6/6FbE2Yc
 7hVpQfcPUU/dLfcCOA1ExIi6ygVwckb50neT9wLAzk+LUnl4RDWwqyHbaXbDBL0Domhy
 54Hw==
X-Gm-Message-State: AOJu0YyGbBaaNXTyv8SMHjOUFy4WLswahRGoeODrf/FHI0etC3OfRlQ8
 U8bUe5d5Aao4gpmSR7d+flnEGN2UatzhcoMQ/qVwQwHfDrM71UbVRDIzueUT5yNY+3lqtuHNNRt
 49q84kOrFj8eTGzOSku7CGH4=
X-Received: by 2002:a2e:9248:0:b0:2b6:e2cd:20f5 with SMTP id
 v8-20020a2e9248000000b002b6e2cd20f5mr1428527ljg.9.1694776861784; 
 Fri, 15 Sep 2023 04:21:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGh7/SV7foEDRaJJLK1TWrPSJ0Tw9S3P18b+71779v96rBrW1vbqKUec2FhfTlxTrnHEO5spw==
X-Received: by 2002:a2e:9248:0:b0:2b6:e2cd:20f5 with SMTP id
 v8-20020a2e9248000000b002b6e2cd20f5mr1428514ljg.9.1694776861444; 
 Fri, 15 Sep 2023 04:21:01 -0700 (PDT)
Received: from ?IPV6:2003:cf:d708:66e5:a5d0:fe92:2899:7179?
 (p200300cfd70866e5a5d0fe9228997179.dip0.t-ipconnect.de.
 [2003:cf:d708:66e5:a5d0:fe92:2899:7179])
 by smtp.gmail.com with ESMTPSA id
 jw24-20020a17090776b800b009a168ab6ee2sm2275216ejc.164.2023.09.15.04.21.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Sep 2023 04:21:00 -0700 (PDT)
Message-ID: <1088caf4-3f59-84be-25d4-f2574674cb2a@redhat.com>
Date: Fri, 15 Sep 2023 13:21:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] qcow2: keep reference on zeroize with discard-no-unref
 enabled
Content-Language: en-US
To: Jean-Louis Dupond <jean-louis@dupond.be>, qemu-devel@nongnu.org,
 kwolf@redhat.com
References: <20230905130839.923041-2-jean-louis@dupond.be>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230905130839.923041-2-jean-louis@dupond.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 05.09.23 15:08, Jean-Louis Dupond wrote:
> When the discard-no-unref flag is enabled, we keep the reference for
> normal discard requests.
> But when a discard is executed on a snapshot/qcow2 image with backing,
> the discards are saved as zero clusters in the snapshot image.
>
> When committing the snapshot to the backing file, not
> discard_in_l2_slice is called but zero_in_l2_slice. Which did not had
> any logic to keep the reference when discard-no-unref is enabled.
>
> Therefor we add logic in the zero_in_l2_slice call to keep the reference
> on commit.
>
> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/1621
> Signed-off-by: Jean-Louis Dupond <jean-louis@dupond.be>
> ---
>   block/qcow2-cluster.c | 22 ++++++++++++++++++----
>   1 file changed, 18 insertions(+), 4 deletions(-)

The code looks OK, but the obvious problem I find is that this is not 
what the discard-no-unref option describes.  It talks about discards, 
but this now changes the zero-write path.

I’m fairly certain that you are the only one using this option for now, 
so we might as well change its definition to include zero writes for 
8.2, but we should do that.

Hanna


