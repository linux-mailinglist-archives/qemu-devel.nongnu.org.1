Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D788D5C1E
	for <lists+qemu-devel@lfdr.de>; Fri, 31 May 2024 09:54:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCx59-0006KD-L9; Fri, 31 May 2024 03:53:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sCx55-0006JW-4k
 for qemu-devel@nongnu.org; Fri, 31 May 2024 03:53:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sCx53-0007pZ-6F
 for qemu-devel@nongnu.org; Fri, 31 May 2024 03:53:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717142019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=91zSxJ4aAp1ylFrKYc0bO2btREv0Y0ZD5+BSMqAWsTc=;
 b=hYznL0QNdfQgi3V8TE42eIsHQQ76pFLtm33JKXa2uaMaRZP89I3Ei0/+2mHF9YpZOjWjtM
 fZc7/av2B3vw/nTKSc5RwiRiQwWEFPJit/3NgYvbF1Dl5cjoeIpHwGuQEcnPiaWzJdGHhX
 UIhvSXE7j7UJvyApNPxGwxZiT3ywbGw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-jhGSzrIXOvSH2VsflpL62g-1; Fri, 31 May 2024 03:53:37 -0400
X-MC-Unique: jhGSzrIXOvSH2VsflpL62g-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4212a921370so8127015e9.3
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 00:53:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717142016; x=1717746816;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=91zSxJ4aAp1ylFrKYc0bO2btREv0Y0ZD5+BSMqAWsTc=;
 b=WR4HtHtL/rMCXRVJzm9TUesuFnzgsHQPiOn09dw0qZx5f1TfvKWtSKsDGfNpTcbZaw
 +6S9svp5hP/zJTeY+MVonV8o7jb3+Jgedk1x+P78HnlOlndH3CD1UEwKq6lioEEJ+6SF
 JGg/H/+Z6jbbc06ghkIXSnrWJ6pqBWlauND1Hof21BZ1kwzfg+erfAB/wRBcycesBSdd
 oDAJ5/F4bV0bL7SjAZiWwy2F6tOBkUZ1x2LVcfK4yMFrD/yRt4kTb0VPDhsQjk8VI72q
 21nrDB+rilRtx4iN65BvpCMOyEt2qfI6Ctko1x1nA9si/FgIvxVfBtQarbCSU41OuJk9
 w3dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUY2DMeLBpHSc6VJ7DX2uWZEmMfFDMm+iz7JcIcZof1fIUtQIpVTFK/t3i7JTW5evtomhIyJ9AMkGq0XBQNkQUTfBUrddY=
X-Gm-Message-State: AOJu0YzjZkNsnCsBBEGB4g4hvBiCw6CPQw4STAdEYud5G1p90DJJCFjc
 c5OHXBPGCILXyFhrtIZL2wPMq88OzcZ3Y9nJdDeNblUpo1XJdmdGGyYPbFbPAv3lVvngE747n0y
 szMystHqUxvMxAStXCOLPkmPpBFq6XhMCk2YMLHb3AKXMFxV3FN1e
X-Received: by 2002:a05:600c:3541:b0:415:540e:74e3 with SMTP id
 5b1f17b1804b1-4212e0c3fe8mr10653365e9.40.1717142016633; 
 Fri, 31 May 2024 00:53:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHN3vVO8UL9r75+3SISLB9gIqaiS3+0ZHYwHxsYkeAc/TGWj8s/hBLZcjkUVHfauCS+rhXFVA==
X-Received: by 2002:a05:600c:3541:b0:415:540e:74e3 with SMTP id
 5b1f17b1804b1-4212e0c3fe8mr10653135e9.40.1717142016115; 
 Fri, 31 May 2024 00:53:36 -0700 (PDT)
Received: from ?IPV6:2003:cb:c717:a000:d4df:4b8f:37d4:59e4?
 (p200300cbc717a000d4df4b8f37d459e4.dip0.t-ipconnect.de.
 [2003:cb:c717:a000:d4df:4b8f:37d4:59e4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4212f0f9660sm5666915e9.39.2024.05.31.00.53.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 May 2024 00:53:35 -0700 (PDT)
Message-ID: <dfbdd318-705c-47a8-a192-10c5a8118f26@redhat.com>
Date: Fri, 31 May 2024 09:53:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] osdep: Make qemu_madvise() return ENOSYS on
 unsupported OSes
To: Michal Privoznik <mprivozn@redhat.com>, qemu-devel@nongnu.org
Cc: imammedo@redhat.com
References: <cover.1717140354.git.mprivozn@redhat.com>
 <4dc484ae240edf8df0de14edefc3c3a717a1c781.1717140354.git.mprivozn@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <4dc484ae240edf8df0de14edefc3c3a717a1c781.1717140354.git.mprivozn@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
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

On 31.05.24 09:28, Michal Privoznik wrote:
> Not every OS is capable of madvise() or posix_madvise() even. In
> that case, errno should be set to ENOSYS as it reflects the cause
> better. This also mimic what madvise()/posix_madvise() would
> return if kernel lacks corresponding syscall (e.g. due to
> configuration).

Yes and no. According to the man page

" EINVAL advice is not a valid."

if a particular MADV_* call is not implemented, we would get EINVAL, 
which is really unfortunate ... to detect what is actually supported :(

For the patch here ENOSYS makes sense:

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


