Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D937E7B866F
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 19:26:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo5dg-00016p-Dt; Wed, 04 Oct 2023 13:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo5dY-000165-Lk
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:26:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo5dW-0005hn-8O
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:26:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696440373;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=BWwqlg+GwURftDJRx6D5Dathte6UvYik8xt01lvabzI=;
 b=L9J8N24lTrYD9WTib7hiq175jZcNtiv6/iX2dAlmLlgsUjhTLWm9TuMqcWjBs1fODFPJU9
 EEXg+LXv3Yjlxd6G55EfwN/MV3gdEYs8VIz2DYpIWW5TG20aMzeRKpr865UlE0oYjteYH2
 HzbGFtAKjcVIb5V/g1FGduTDjVeecDY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-4cGLk5Q3OQaVJXrnZil6gw-1; Wed, 04 Oct 2023 13:26:12 -0400
X-MC-Unique: 4cGLk5Q3OQaVJXrnZil6gw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-405535740d2so207885e9.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 10:26:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696440371; x=1697045171;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BWwqlg+GwURftDJRx6D5Dathte6UvYik8xt01lvabzI=;
 b=u2zvYiTVBR/7jU2+jdyg7YGga0Cw17T0Xxyf48IVwQ/Ew325UtjlSkj2JOzXe6Q49V
 gpfWHm3sN4hDlxlAER9WddTfveBK0s4Mnxp7Afgn8AI8I77dlb8J3mdceNiRsUnjSS8+
 e/11XydPKBdh04c3IXlzAFw2x4WMQ/jdBf7BpzE0y31Rkvfdvm/qVX6EcmsOV1XaagQU
 GtBE3B3Cw3w4G/sj/0JJAFip3pN6XmzgXqc8ZlXQ1iMbRiYFvurOKMYOaKNpxINL3mfs
 yZ/XzZ3lKHbDgWn9/QQzAZ4CFFLIYnMgL41c6ZVsknT0JQ5VXAdLh6bnyCTjpz+T524Z
 T32Q==
X-Gm-Message-State: AOJu0YxS/72elFz/aAP1HYCbpztS0IZwyv0I7nnZBXpmn9D/tEMD8LGw
 yp9fJYL5dmgHaFEfjIylajqduwDYJvHSzX3BfT1ktnBZTZETwH74G7aTZG/s3s4cIh6hnlC6BPa
 XCCmI+/0/TceoRCU=
X-Received: by 2002:a05:600c:2054:b0:402:906:1e87 with SMTP id
 p20-20020a05600c205400b0040209061e87mr2766465wmg.31.1696440371152; 
 Wed, 04 Oct 2023 10:26:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHggjv3PHhvMtopeFpgKAFY114F9T9GX2wD+Jm5UiLpQd8GU78FsMiN90wvWLM/wDx/IQgSng==
X-Received: by 2002:a05:600c:2054:b0:402:906:1e87 with SMTP id
 p20-20020a05600c205400b0040209061e87mr2766450wmg.31.1696440370866; 
 Wed, 04 Oct 2023 10:26:10 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 15-20020a05600c028f00b00406443c8b4fsm2021579wmk.19.2023.10.04.10.26.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 10:26:10 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Li Zhijian <lizhijian@fujitsu.com>,  Fabiano
 Rosas <farosas@suse.de>,  Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v2 00/10] Removal of QEMUFileHooks
In-Reply-To: <ZR2cxboX7T5p9OyT@x1n> (Peter Xu's message of "Wed, 4 Oct 2023
 13:11:33 -0400")
References: <20231004124913.16360-1-quintela@redhat.com> <ZR2cxboX7T5p9OyT@x1n>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 19:26:09 +0200
Message-ID: <87ttr6s3im.fsf@secure.mitica>
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

Peter Xu <peterx@redhat.com> wrote:
> On Wed, Oct 04, 2023 at 02:49:03PM +0200, Juan Quintela wrote:
>> I remove the reviewed by from peter for 2-6 because I had to touch
>> those files.
>
> You yet didn't? :)
>
> I saw you plan to rebase yours onto Markus's.  I'll wait for a new version.

Too many rebases O:-)

I swear that I did it ... on some branch O:-)

Thanks, Juan.


