Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D24647782AB
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 23:26:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUD9I-0000wB-Is; Thu, 10 Aug 2023 17:24:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qUD9G-0000vl-RT
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 17:24:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qUD9F-0007fe-AU
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 17:24:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691702687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MohpISlW2ke/5nCqHDekdHRjwrgOP2Qjg6O1AqVsURU=;
 b=Nf7fgjTCPDkhBlwb79qz+BX5I/1Fq4kG4s9qFpLXfodxDaznDnsQWlV+RYaLg+yZ6o0jCq
 ybXjZCblDdWOY4/Sx5twrIE9L2b/Zxp1OG50tuPTWuFdZhlZt+o3pJ1TwvbCTChyfL6yu+
 MYoZf2jSmDEiIld5rQ0vVQ6sG/i8ABE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-k6GS9ifdNvKfoSFVZ5zlAQ-1; Thu, 10 Aug 2023 17:24:45 -0400
X-MC-Unique: k6GS9ifdNvKfoSFVZ5zlAQ-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-637948b24bdso3581186d6.1
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 14:24:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691702685; x=1692307485;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MohpISlW2ke/5nCqHDekdHRjwrgOP2Qjg6O1AqVsURU=;
 b=cXqKKpLT8qVXO7jDj30E2j5S/sqqicDJHuuJsUWqx4TokKYfFfYwm+qgTDfvCvkVRC
 9Xq6FUbJJzxvqe38XMH1RFKghIPGgRSpqCJEbV0imSzjeYGnKmFc75gC17Jy7D/SG5au
 NMgkwde6FAg2Dg9QK01+i/RkJfBTq/Up9gnkjhLkdjEodiVEzGfE3z36TKogP5WVHxh/
 6bRflc+SKS1uGVYoTw5/xj4+RdoyatZJ2May1WUE1VMNhrJBkgKTCEXLfzJgQdDIZW0P
 1e/Ch97GAnIxkqx5TA7DXwq7qFesFTF6PTPEk8LOMe6/B2JCc5BgBi6cDiZGTG+S0l1q
 eQEQ==
X-Gm-Message-State: AOJu0Ywe3vpwNf1aST4o+IbwjqCwL8Gy1Y/IoZjxHpaLgHpEF6y34SqI
 Tm47q2s4UFLnEWTkZlwajyZOROZXL5zNZzwkeD13d5e+MBTayS4Ho40MowddR3wfxGeEXJxCo5Q
 1Ums8uJTzt/ABg38=
X-Received: by 2002:ad4:5dca:0:b0:616:870c:96b8 with SMTP id
 m10-20020ad45dca000000b00616870c96b8mr4446109qvh.3.1691702685304; 
 Thu, 10 Aug 2023 14:24:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHU3uUklnzv0VHlxPGMP76p3SDAu6tP+IcGGmTYOCX7Mu/Epjt3oUAKI8ALXiCuEsIrrET4sA==
X-Received: by 2002:ad4:5dca:0:b0:616:870c:96b8 with SMTP id
 m10-20020ad45dca000000b00616870c96b8mr4446081qvh.3.1691702685010; 
 Thu, 10 Aug 2023 14:24:45 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 g20-20020a0cdf14000000b0063d585225e0sm740577qvl.61.2023.08.10.14.24.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Aug 2023 14:24:44 -0700 (PDT)
Date: Thu, 10 Aug 2023 17:24:43 -0400
From: Peter Xu <peterx@redhat.com>
To: ThinerLogoer <logoerthiner1@163.com>
Cc: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: Re: [PATCH v1 1/3] softmmu/physmem: fallback to opening guest
 RAM file as readonly in a MAP_PRIVATE mapping
Message-ID: <ZNVVmxuQAsSEHqZq@x1n>
References: <20230807190736.572665-1-david@redhat.com>
 <20230807190736.572665-2-david@redhat.com> <ZNKtHVotkfgI1tb4@x1n>
 <1d1a7d8f-6260-5905-57ea-514b762ce869@redhat.com>
 <ZNOti1OKN79t68jP@x1n>
 <e9c53fbd-369c-2605-1470-e67a765f923b@redhat.com>
 <6152f171.6a4c.189e069baf7.Coremail.logoerthiner1@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6152f171.6a4c.189e069baf7.Coremail.logoerthiner1@163.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Fri, Aug 11, 2023 at 01:06:12AM +0800, ThinerLogoer wrote:
> >I think we have the following options (there might be more)
> >
> >1) This patch.
> >
> >2) New flag for memory-backend-file. We already have "readonly" and 
> >"share=". I'm having a hard time coming up with a good name that really 
> >describes the subtle difference.
> >
> >3) Glue behavior to the QEMU machine
> >
> 
> 4) '-deny-private-discard' argv, or environment variable, or both

I'd personally vote for (2).  How about "fdperm"?  To describe when we want
to use different rw permissions on the file (besides the access permission
of the memory we already provided with "readonly"=XXX).  IIUC the only sane
value will be ro/rw/default, where "default" should just use the same rw
permission as the memory ("readonly"=XXX).

Would that be relatively clean and also work in this use case?

(the other thing I'd wish we don't have that fallback is, as long as we
 have any of that "fallback" we'll need to be compatible with it since
 then, and for ever...)

-- 
Peter Xu


