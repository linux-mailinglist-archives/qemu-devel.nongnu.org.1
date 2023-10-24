Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FDF7D4EC8
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 13:24:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvFVF-0005QN-UN; Tue, 24 Oct 2023 07:23:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvFVD-0005P5-Vo
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 07:23:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvFVC-00018U-Bl
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 07:23:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698146593;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=aoe01r4jYivi9hbKboDqHdR26boeLOgGI/gNL6rYKyo=;
 b=CsdJLcDzdXUGutzJFNtePiRuW17GEkAroLLxloIl3y5gLhItlIyVQwpk3XpGh5vVzHp5jd
 DHoW++KWLXZyFOLedeDAXP5lBxLI05YLgLeviVvfNZaBMHIuEQXoUsaYPrEGRQ3GbJH19r
 jptpQ24s1+uipDdP2pzn+Kuvnk+GjAs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-M5OevwOCOHKdi7tG7yBVSA-1; Tue, 24 Oct 2023 07:23:12 -0400
X-MC-Unique: M5OevwOCOHKdi7tG7yBVSA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3172a94b274so2007212f8f.0
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 04:23:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698146591; x=1698751391;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aoe01r4jYivi9hbKboDqHdR26boeLOgGI/gNL6rYKyo=;
 b=KVfIaA8yagZhq3wmlUKDjaLK/Z9krkC04kj4AqRSeqgCzSiET5JXyRIU9BJmRIyqae
 rtlpC+/Lbcp2GuBRVJ13mPPYvppnZ/ehssoStKiCnF1AEeTgaMflOuC2HraQ2NEY0QV6
 z3mgddGQMwTD3qeD7Cyh7Ivg8iOxnB2v19IjVppHfthI8ISZHAs5S+33zfhQ8u1acy7/
 IrDkmAESmc4GvRrYdlDxjq3e998GYFqbhxx8GsxDpyTWIYnWdRm09Vj8Au8LeOzsxXHd
 BtRxSSdpthUGht4aD9xpc28nCmXsz5Bp+WjlD0JDWn5+e69aF1br0PKMHO3tLMGYkYRz
 MTWA==
X-Gm-Message-State: AOJu0YyndjOKM577mTu1xZaARBWmU0WS+m2A7mWza+jdhZf9VXF7vm5N
 4G2jl8IWDLg27BPgQ5ZxoNLhwxf3B4de+JxBBdsjsuhONAyybPcxfFggByyBoNVQQi3e934t8jJ
 pI1v4xhcK9l9UQEE=
X-Received: by 2002:adf:efcd:0:b0:32d:ad4a:bcef with SMTP id
 i13-20020adfefcd000000b0032dad4abcefmr8394045wrp.2.1698146590959; 
 Tue, 24 Oct 2023 04:23:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGV/301Ga/u0i53UMjrzOeNGx0tZbclB3LCFXHk9eh7um/n06YnYF6UMCAzIrEqihp6TZ2Wog==
X-Received: by 2002:adf:efcd:0:b0:32d:ad4a:bcef with SMTP id
 i13-20020adfefcd000000b0032dad4abcefmr8394024wrp.2.1698146590552; 
 Tue, 24 Oct 2023 04:23:10 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 f7-20020adff587000000b0031fb91f23e9sm9708148wro.43.2023.10.24.04.23.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 04:23:09 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org,  Stefan Hajnoczi <stefanha@redhat.com>,  Fabiano
 Rosas <farosas@suse.de>,  Kevin Wolf <kwolf@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  qemu-block@nongnu.org,  Leonardo Bras
 <leobras@redhat.com>,  Markus Armbruster <armbru@redhat.com>,  Fam Zheng
 <fam@euphon.net>,  Peter Xu <peterx@redhat.com>,  libvir-list@redhat.com
Subject: Re: [PATCH v8 1/5] qemu-iotests: Filter warnings about block
 migration being deprecated
In-Reply-To: <0eb68c96-457f-471f-ad2f-f6282eaf04a2@redhat.com> (Hanna
 Czenczek's message of "Tue, 24 Oct 2023 13:11:11 +0200")
References: <20231018115513.2163-1-quintela@redhat.com>
 <20231018115513.2163-2-quintela@redhat.com>
 <0eb68c96-457f-471f-ad2f-f6282eaf04a2@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 24 Oct 2023 13:23:09 +0200
Message-ID: <87bkcoz2le.fsf@secure.mitica>
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

Hanna Czenczek <hreitz@redhat.com> wrote:
> On 18.10.23 13:55, Juan Quintela wrote:
>> Create a new filter that removes the two warnings for test 183.
>>
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>   tests/qemu-iotests/183           | 2 +-
>>   tests/qemu-iotests/common.filter | 7 +++++++
>>   2 files changed, 8 insertions(+), 1 deletion(-)
>
> Reviewed-by: Hanna Czenczek <hreitz@redhat.com>

Thanks.


