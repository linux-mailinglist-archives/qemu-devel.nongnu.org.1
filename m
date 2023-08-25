Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E98788BBC
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 16:30:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZXoO-0001un-Ml; Fri, 25 Aug 2023 10:29:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qZXoL-0001uO-4P
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 10:29:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qZXoI-0005m2-LD
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 10:29:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692973754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DesvM8ug+jiD3fwu6+WkO0JygHaYbvBHb2lGaWmx6M4=;
 b=DxvDC9iOkIrFrq8yRPXDK/675Y5VBpE2FrS5sw3G69vZWrksa+ymRYGLPy6in+F22wwk58
 p9KfKCfWdqthiCh3Gd3yt4XB0i2oSPXfdfwozTvgd/T6b404RAnWtherz5Vnv0QBAc8n4Q
 ue7peAl6fhryoKVj/HZLyTACOzrrM30=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-AGuNgGGPNu2IrnWqC562ag-1; Fri, 25 Aug 2023 10:29:12 -0400
X-MC-Unique: AGuNgGGPNu2IrnWqC562ag-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-99bdee94b84so166640166b.0
 for <qemu-devel@nongnu.org>; Fri, 25 Aug 2023 07:29:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692973750; x=1693578550;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DesvM8ug+jiD3fwu6+WkO0JygHaYbvBHb2lGaWmx6M4=;
 b=CuJP8xfpdS3KvMuP0tUDyl00/zQ+BwHPYtfq/XY/ujkLnxqO3VXMnFEZ0oDwHVpoII
 IqUDyyTTa/bQlDvb6n2I4WjuOjKwBcYZCYGw/FcQzSbQBJeS/DTQMLvZKBVqf4nAmIEU
 ucGP24obltI1Lz7Vms+35enVArw9C6EYyPcXy3S264L+VceyiovPu3ApWR8u7xC8BLoQ
 8uyOBFfbD3zRrsTuBdr0SnbHUtIk1wGoW9uN/lWkYzRiVGLNd1wmtxA2WxYJMzNqTuh/
 62xZbjNR5XJgYsreDYTacrSfjkmfzlQN+NNAhGxcWp2Cf0N7+MHQ4DJCHqH/qW3nMsLn
 mAPw==
X-Gm-Message-State: AOJu0YxP/o4vPKhNYbkaHCkHFOuClJZOcrJuWWEahKJg4niw9K3ZKQMV
 6XtqEs7CqoAODLlxzg1oa4OsKm6jyKs7iYkMo7gioeZDbfLVLvN5lLbvKeGxZPZ+balaHx6i3wW
 iSu8hFflzmquLU3aDqgF1oy0=
X-Received: by 2002:a17:907:97cf:b0:9a1:8993:9532 with SMTP id
 js15-20020a17090797cf00b009a189939532mr17270217ejc.30.1692973750542; 
 Fri, 25 Aug 2023 07:29:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrDGCWUt28WM7B4fxCIkQP8HQW1vReb2J2/yARuDSI47htf650QudOu4YS4Xey9W2EaFJThg==
X-Received: by 2002:a17:907:97cf:b0:9a1:8993:9532 with SMTP id
 js15-20020a17090797cf00b009a189939532mr17270203ejc.30.1692973750257; 
 Fri, 25 Aug 2023 07:29:10 -0700 (PDT)
Received: from ?IPV6:2003:cf:d70f:5ee0:6d7a:8486:6b83:8d37?
 (p200300cfd70f5ee06d7a84866b838d37.dip0.t-ipconnect.de.
 [2003:cf:d70f:5ee0:6d7a:8486:6b83:8d37])
 by smtp.gmail.com with ESMTPSA id
 q4-20020a170906144400b00992eabc0ad8sm1030201ejc.42.2023.08.25.07.29.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Aug 2023 07:29:09 -0700 (PDT)
Message-ID: <c348e12f-4667-3459-ef2c-86b514456132@redhat.com>
Date: Fri, 25 Aug 2023 16:29:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/6] qemu-img: rebase: use backing files' BlockBackend for
 buffer alignment
Content-Language: en-US
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, den@virtuozzo.com
References: <20230601192836.598602-1-andrey.drobyshev@virtuozzo.com>
 <20230601192836.598602-4-andrey.drobyshev@virtuozzo.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230601192836.598602-4-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.57, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 01.06.23 21:28, Andrey Drobyshev via wrote:
> Since commit bb1c05973cf ("qemu-img: Use qemu_blockalign"), buffers for
> the data read from the old and new backing files are aligned using
> BlockDriverState (or BlockBackend later on) referring to the target image.
> However, this isn't quite right, because target image is only being
> written to and has nothing to do with those buffers.  Let's fix that.

I don’t understand.  The write to the target image does use one of those 
buffers (buf_old, specifically).

This change is correct for buf_new/blk_new_backing, but for buf_old, in 
theory, we need a buffer that fulfills both the alignment requirements 
of blk and blk_old_backing.  (Not that this patch really makes the 
situation worse for buf_old.)

Hanna


