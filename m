Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5638C7E05C6
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 16:52:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qywSA-0006Ts-Ed; Fri, 03 Nov 2023 11:51:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qywS6-0006Sn-AQ
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 11:51:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qywS4-0001JP-CI
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 11:51:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699026673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z1dIWAE3rR0uorQ6Ko9KLqv/iwcvTokvSE7ubudovNk=;
 b=aYdGOmQJjgEk7O8+7Qhv4CN0fQV1xk7rjIXPCLFJWlDqaHf3hFbOjVseYAtBMQSTfXZJDw
 1ENBVO30VwAo8jKYnCypuRbszIdvoB0R4XSkMkO2dRmm2EizJF2ScM3bmSoNwlAmFbdCgR
 JR/lMk9TXeF76vtgRrX/Ahx05CNKXKs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-nrVy86H4OnWD09zHOJJT2w-1; Fri, 03 Nov 2023 11:51:12 -0400
X-MC-Unique: nrVy86H4OnWD09zHOJJT2w-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40920512cd3so14317025e9.1
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 08:51:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699026670; x=1699631470;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z1dIWAE3rR0uorQ6Ko9KLqv/iwcvTokvSE7ubudovNk=;
 b=ALQ3h5OvIDaTSs00JdeuPjR+/w6xwgVlhsnAQxc2uCWsARc4Iq2FtZausjVsPdQ6CI
 YQiM/XxVGj3PouSZP3yI/98IEigK3WtfSlataChJxPAPeWNpuRVny1Ij1IpkzXdYazTO
 Ycfb/2CsdsJL3TYjrpQubY7mGRNKq5xoD/F1ZVLVk9I8jbyzTKbsXf60UukDGxsjTuGW
 6dKo4RiAiAKG1pkoB3ocyS0L1bmJzfHL5J6UbB11JE9QKcUnD2FmS85x79ebEfg5qaNa
 MBd8VeDdlu04fk4AAxl8paq8oXfb9y9ibM1s2OoZdSdXLAvYQRIgk4K8ZQaXXFtFTArT
 QZMw==
X-Gm-Message-State: AOJu0YwVEhO52WcOsfNjvsAB7rEL/JL6DxvxB2usWYt9dvs1CH56AH5b
 aCEE+BSgN2FDQ+ITOnKfNbW/901NHfQEISVQfq3XzAvyEHCbA+5FVdRPQpvOv0RsHu2v84SRReg
 7jmA86qdQvXsiNCkd5/2m414=
X-Received: by 2002:a05:600c:1f88:b0:409:404e:5b9a with SMTP id
 je8-20020a05600c1f8800b00409404e5b9amr12746400wmb.33.1699026670532; 
 Fri, 03 Nov 2023 08:51:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLopXEjfIScxZNU5+0iNl6Y9kCeC9fP+70pF/vDtlCQ8CVc1zPAodMuDpkSXe3tANJH5hR8Q==
X-Received: by 2002:a05:600c:1f88:b0:409:404e:5b9a with SMTP id
 je8-20020a05600c1f8800b00409404e5b9amr12746377wmb.33.1699026670074; 
 Fri, 03 Nov 2023 08:51:10 -0700 (PDT)
Received: from ?IPV6:2003:cf:d718:8590:77de:e1fd:a4df:d080?
 (p200300cfd718859077dee1fda4dfd080.dip0.t-ipconnect.de.
 [2003:cf:d718:8590:77de:e1fd:a4df:d080])
 by smtp.gmail.com with ESMTPSA id
 k8-20020a05600c1c8800b004081a011c0esm2918776wms.12.2023.11.03.08.51.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Nov 2023 08:51:09 -0700 (PDT)
Message-ID: <90298f38-fe14-4659-87a3-9b4bd2f516df@redhat.com>
Date: Fri, 3 Nov 2023 16:51:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] iotests/271: check disk usage on subcluster-based
 discard/unmap
Content-Language: en-US
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, eblake@redhat.com,
 berto@igalia.com, den@virtuozzo.com
References: <20231020215622.789260-1-andrey.drobyshev@virtuozzo.com>
 <20231020215622.789260-8-andrey.drobyshev@virtuozzo.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20231020215622.789260-8-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.47,
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

On 20.10.23 23:56, Andrey Drobyshev wrote:
> Add _verify_du_delta() checker which is used to check that real disk
> usage delta meets the expectations.  For now we use it for checking that
> subcluster-based discard/unmap operations lead to actual disk usage
> decrease (i.e. PUNCH_HOLE operation is performed).

I’m not too happy about checking the disk usage because that relies on 
the underlying filesystem actually accepting and executing the unmap.  
Why is it not enough to check the L2 bitmap?

…Coming back later (I had to fix the missing `ret = ` I mentioned in 
patch 2, or this test would hang, so I couldn’t run it at first), I note 
that checking the disk usage in fact doesn’t work on tmpfs.  I usually 
run the iotests in tmpfs, so that’s not great.

> Also add separate test case for discarding particular subcluster within
> one cluster.
>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>   tests/qemu-iotests/271     | 25 ++++++++++++++++++++++++-
>   tests/qemu-iotests/271.out |  2 ++
>   2 files changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/tests/qemu-iotests/271 b/tests/qemu-iotests/271
> index c7c2cadda0..5fcb209f5f 100755
> --- a/tests/qemu-iotests/271
> +++ b/tests/qemu-iotests/271
> @@ -81,6 +81,15 @@ _verify_l2_bitmap()
>       fi
>   }
>   
> +# Check disk usage delta after a discard/unmap operation
> +# _verify_du_delta $before $after $expected_delta
> +_verify_du_delta()
> +{
> +    if [ $(($1 - $2)) -ne $3 ]; then
> +        printf "ERROR: unexpected delta: $1 - $2 = $(($1 - $2)) != $3\n"
> +    fi
> +}
> +
>   # This should be called as _run_test c=XXX sc=XXX off=XXX len=XXX cmd=XXX
>   # c:   cluster number (0 if unset)
>   # sc:  subcluster number inside cluster @c (0 if unset)
> @@ -198,9 +207,12 @@ for use_backing_file in yes no; do
>       alloc="$(seq 0 31)"; zero=""
>       _run_test sc=0 len=64k
>   
> -    ### Zero and unmap half of cluster #0 (this won't unmap it)
> +    ### Zero and unmap half of cluster #0 (this will unmap it)

I think “it” refers to the cluster, and it is not unmapped.  This test 
case does not use a discard, but write -z instead, so it worked before.  
(The L2 bitmap shown in the output doesn’t change, so functionally, this 
patch series didn’t change this case.)

>       alloc="$(seq 16 31)"; zero="$(seq 0 15)"
> +    before=$(disk_usage "$TEST_IMG")
>       _run_test sc=0 len=32k cmd=unmap
> +    after=$(disk_usage "$TEST_IMG")
> +    _verify_du_delta $before $after 32768
>   
>       ### Zero and unmap cluster #0
>       alloc=""; zero="$(seq 0 31)"

For this following case shown truncated here, why don’t we try 
“_run_test sc=16 len=32k cmd=unmap” instead of “sc=0 len=64k”?  I.e. 
unmap only the second half, which, thanks to patch 3, should still unmap 
the whole cluster, because the first half is already unmapped.

> @@ -447,7 +459,10 @@ for use_backing_file in yes no; do
>   
>       # Subcluster-aligned request from clusters #12 to #14
>       alloc="$(seq 0 15)"; zero="$(seq 16 31)"
> +    before=$(disk_usage "$TEST_IMG")
>       _run_test c=12 sc=16 len=128k cmd=unmap
> +    after=$(disk_usage "$TEST_IMG")
> +    _verify_du_delta $before $after $((128 * 1024))
>       alloc=""; zero="$(seq 0 31)"
>       _verify_l2_bitmap 13
>       alloc="$(seq 16 31)"; zero="$(seq 0 15)"
> @@ -528,6 +543,14 @@ for use_backing_file in yes no; do
>       else
>           _make_test_img -o extended_l2=on 1M
>       fi
> +    # Write cluster #0 and discard its subclusters #0-#3
> +    $QEMU_IO -c 'write -q 0 64k' "$TEST_IMG"
> +    before=$(disk_usage "$TEST_IMG")
> +    $QEMU_IO -c 'discard -q 0 8k' "$TEST_IMG"
> +    after=$(disk_usage "$TEST_IMG")
> +    _verify_du_delta $before $after 8192
> +    alloc="$(seq 4 31)"; zero="$(seq 0 3)"
> +    _verify_l2_bitmap 0
>       # Write clusters #0-#2 and then discard them
>       $QEMU_IO -c 'write -q 0 128k' "$TEST_IMG"
>       $QEMU_IO -c 'discard -q 0 128k' "$TEST_IMG"

Similarly to above, I think it would be good if we combined this 
following case with the one you added, i.e. to write 128k from the 
beginning, drop the write here, and change the discard to be “discard -q 
8k 120k”, i.e. skip the subclusters we have already discarded, to see 
that this is still combined to discard the whole first cluster.

...Ah, see, and when I try this, the following assertion fails:

qemu-io: ../block/qcow2-cache.c:156: qcow2_cache_destroy: Assertion 
`c->entries[i].ref == 0' failed.
./common.rc: line 220: 128894 Aborted                 (core dumped) ( 
VALGRIND_QEMU="${VALGRIND_QEMU_IO}" _qemu_proc_exec 
"${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )

Looks like an L2 table is leaked somewhere.  That’s why SCRI should be a 
g_auto()-able type.

Hanna

> diff --git a/tests/qemu-iotests/271.out b/tests/qemu-iotests/271.out
> index 5be780de76..0da8d72cde 100644
> --- a/tests/qemu-iotests/271.out
> +++ b/tests/qemu-iotests/271.out
> @@ -426,6 +426,7 @@ L2 entry #29: 0x0000000000000000 0000ffff00000000
>   ### Discarding clusters with non-zero bitmaps (backing file: yes) ###
>   
>   Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=raw
> +L2 entry #0: 0x8000000000050000 0000000ffffffff0
>   L2 entry #0: 0x0000000000000000 ffffffff00000000
>   L2 entry #1: 0x0000000000000000 ffffffff00000000
>   Image resized.
> @@ -436,6 +437,7 @@ L2 entry #1: 0x0000000000000000 ffffffff00000000
>   ### Discarding clusters with non-zero bitmaps (backing file: no) ###
>   
>   Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
> +L2 entry #0: 0x8000000000050000 0000000ffffffff0
>   L2 entry #0: 0x0000000000000000 ffffffff00000000
>   L2 entry #1: 0x0000000000000000 ffffffff00000000
>   Image resized.


