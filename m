Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BDA7B86FD
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 19:52:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo62s-0000uI-Uz; Wed, 04 Oct 2023 13:52:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo62p-0000u4-Jk
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:52:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo62o-0007Zw-6F
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:52:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696441941;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=mtuTP+Q1j+KLtqkCGDrFyo5DiYFtFIr5jfbQCLUd2Yo=;
 b=H+oPxueQZAeTWo5O3y3Uobyz3IcSAU7DVDtHxRqimaCWQ9ZhHs0mCFIvFe8k7/ElQ4xB8C
 zAq/DKcJuf23DT2+RNk2T0bBHKIVHjiPlWzat+9CsBKnW2+bZZaAdOCVfbwgltppyRgCiQ
 itHemvVUVoeh92qYwmB5RAPS1EthN98=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-sXMJ8SY_PxG-2-1AV1bGQg-1; Wed, 04 Oct 2023 13:52:19 -0400
X-MC-Unique: sXMJ8SY_PxG-2-1AV1bGQg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-40590e6bd67so470615e9.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 10:52:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696441938; x=1697046738;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mtuTP+Q1j+KLtqkCGDrFyo5DiYFtFIr5jfbQCLUd2Yo=;
 b=lzp883oK9HZq5LmiE13+0T6If2bo8U0JsN4ay1v1L/p2xbAVIdbp2MUqMcl4n/9BGh
 SgP00Ud6VyHd69iHdM+pASpNGxI7/VJBvFyHXNhxsqEer87RoIZARxcbZVGxGCGnkL/z
 MO3wIFtjZDqRr/FVWnVC20krtfh+IW9lF8QROFKdRYnCCOTxcuDs5VmubYS/qu11JFBN
 PU4n4Qjri8SVUjS6kU651afNxvM31RLQJhaaQIk8WDhVJBYmmiTVuPVdujjENLbraskz
 EPT94BLgBk24JFDuBsv8wy/J601mK65ut3fmwl54GJHPb/iiMYEKHYWb64qt0qP0OMgH
 zhlg==
X-Gm-Message-State: AOJu0YzmnilDrZYSVGFYj/tN44yttFl8W/+5PMZLH9XQMYcIA/lUCM39
 GDzIxEPjRmtNywat8nAgrzMDowvd1euAcr9cOrAZH3+I2GGlwniwc4pyktow/8Y+qfyu64XFzN6
 DSITnVOU6ovjZMPu2bcXZjqV3SQ==
X-Received: by 2002:adf:ed88:0:b0:320:28e:b638 with SMTP id
 c8-20020adfed88000000b00320028eb638mr2911488wro.36.1696441937886; 
 Wed, 04 Oct 2023 10:52:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZD7BD6eBv5WmHYwYKMwXdP8A2uW7g5Fdd5gJexKtBGeJJaVNlcgj5gbrUzRShvXmNdO4SDA==
X-Received: by 2002:adf:ed88:0:b0:320:28e:b638 with SMTP id
 c8-20020adfed88000000b00320028eb638mr2911477wro.36.1696441937608; 
 Wed, 04 Oct 2023 10:52:17 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 j17-20020a5d5651000000b0031f82743e25sm4493532wrw.67.2023.10.04.10.52.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 10:52:16 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  leobras@redhat.com,
 farosas@suse.de,  lizhijian@fujitsu.com,  eblake@redhat.com
Subject: Re: [PATCH v2 00/53] migration/rdma: Error handling fixes
In-Reply-To: <20230928132019.2544702-1-armbru@redhat.com> (Markus Armbruster's
 message of "Thu, 28 Sep 2023 15:19:26 +0200")
References: <20230928132019.2544702-1-armbru@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 19:52:16 +0200
Message-ID: <87fs2qs2b3.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Markus Armbruster <armbru@redhat.com> wrote:
> Oh dear, where to start.  There's so much wrong, and in pretty obvious
> ways.  This code should never have passed review.  I'm refraining from
> saying more; see the commit messages instead.
>
> Issues remaining after this series include:
>
> * Terrible error messages
>
> * Some error message cascades remain
>
> * There is no written contract for QEMUFileHooks, and the
>   responsibility for reporting errors is unclear
>
> * There seem to be no tests whatsoever
>
> PATCH 29 is arguably a matter of taste.  I made my case for it during
> review of v1.  If maintainers don't want it, I'll drop it.
>
> Related: [PATCH 1/7] migration/rdma: Fix save_page method to fail on
> polling error

Hi Markus

I integrated everything except:

>   migration/rdma: Fix or document problematic uses of errno

Most of them are dropped on following patches.

>   migration/rdma: Use error_report() & friends instead of stderr

You said you have to resend this one.

There were some conflicts, I was careful, but one never knows.  So you
are wellcome to take a look when the PULL cames to the tree.

Thanks, Juan.


