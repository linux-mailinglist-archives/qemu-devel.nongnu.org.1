Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 967A07CC58B
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 16:06:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qskhk-0004ds-VK; Tue, 17 Oct 2023 10:05:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qskhf-0004W3-4B
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 10:05:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qskhY-0001Gh-Fs
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 10:05:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697551539;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=RRYZc5G0/JAkWv7TvD/5tZrI7QtivRkUrs5iKfysWk0=;
 b=QFTXoBG/BDt0ikr2fLxTn5KzzsI14b+hNWNwlp+xX0GOwO7tLfTUY+EgvHKwWV+ZMyw1ew
 mUgdnxCVx6N28drZKAvlZePVCN4BHmcCoJemwyU+/yWuocRtUQObVDU7rJdmc14jak//BI
 FluxrCaKBsOBOzO0IelT3LZDfTRFaak=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-QrmJqC8qPauBJF3B4gSfhg-1; Tue, 17 Oct 2023 10:05:37 -0400
X-MC-Unique: QrmJqC8qPauBJF3B4gSfhg-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2c51a7df557so26961771fa.0
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 07:05:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697551536; x=1698156336;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RRYZc5G0/JAkWv7TvD/5tZrI7QtivRkUrs5iKfysWk0=;
 b=GsnhOb24O2PY4gY1dXiJLm9JGcmDZiOdKhFfvNiqXiaYyhrAEBVU8WznsU/+jwhS2L
 6ANPgeVZGDa4cQ6RawZERSwrJeVBNQz3kIZJ9DMRZm/W5SwAp1R4hBo4TtCTyatzdjcH
 XpQhXdkTUi4xbqVLuu2uIoVtOc5qAUMwRwg/nQl/1qdTVBl+FX1KFRkHqR9hiy8kxfUU
 w3hvkzlDx2Zsrdf5+8Nbhit2B1IS9K6rjb+66ZWPOKa8HfEe7a1XZK1WnqQ3AEIMeMO6
 NzYxsRv69bIyU4yAq1nOCLal40MnZlT1aif1QyoFJQB8Q2hRepVyo4o+rSw+aq+Om5tF
 NEZQ==
X-Gm-Message-State: AOJu0YzLfDIgEruTNy3dfUaeif2WVORCOI1AOhVuY93z42Bz1bu44Jjs
 PpQ2M5CrPte6ufFOVAmgz4U4XDS+gwQiBHb1EmiaIyu9nGd7cK+z1I+kTHU9NObpDpMu2D9PNs0
 YzlJbSua5lZ85N3k=
X-Received: by 2002:a05:651c:3c1:b0:2bc:d634:2210 with SMTP id
 f1-20020a05651c03c100b002bcd6342210mr1447012ljp.16.1697551535768; 
 Tue, 17 Oct 2023 07:05:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEO6MCnbtZu9f7BOZ5msSztNDta83C3an0YvRN7tAt1ksLQpunaJ1+a9gtibpo4WsZN9scbFg==
X-Received: by 2002:a05:651c:3c1:b0:2bc:d634:2210 with SMTP id
 f1-20020a05651c03c100b002bcd6342210mr1446965ljp.16.1697551534547; 
 Tue, 17 Oct 2023 07:05:34 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 e13-20020a05600c4e4d00b004065daba6casm10016392wmq.46.2023.10.17.07.05.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 07:05:34 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  "Michael S . Tsirkin" <mst@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,  Jiri Denemark <jdenemar@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,  Fiona Ebner <f.ebner@proxmox.com>,
 Daniel P . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v3 2/3] migration/docs: How to migrate when hosts have
 different features
In-Reply-To: <ZGQW7W8i+y9/KpO1@x1n> (Peter Xu's message of "Tue, 16 May 2023
 19:51:09 -0400")
References: <20230515083201.55060-1-quintela@redhat.com>
 <20230515083201.55060-3-quintela@redhat.com> <ZGQW7W8i+y9/KpO1@x1n>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 17 Oct 2023 16:05:33 +0200
Message-ID: <871qdt1h02.fsf@secure.mitica>
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
> On Mon, May 15, 2023 at 10:32:00AM +0200, Juan Quintela wrote:
>> +$ qemu-system-x86_64 -cpu host,pcid=off,stibp=off
>> +
>> +Host B:
>> +
>> +$ qemu-system-x86_64 -cpu host,taa-no=off
>
> Since we're using cpu as example, shall we at least mention at the end that
> we don't suggest using -cpu host if migration is needed?

Added something like that.

>> +
>> +And you would be able to migrate between them.  It is responsability
>> +of the management application or of the user to make sure that the
>> +configuration is correct.  QEMU don't know how to look at this kind of
>> +features in general.
>> +
>> +Other devices have worse control about individual features.  If they
>> +want to be able to migrate between hosts that show different features,
>> +the device needs a way to configure which ones it is going to use.
>> +
>> +In this section we have considered that we are using the same QEMU
>> +binary in both sides of the migration.  If we use different QEMU
>> +versions process, then we need to have into account all other
>> +differences and the examples become even more complicated.
>
> Mostly good to me.  What I worry is how much help this will bring to
> developers - I'd assume developers working on these will be aware of this.
> But I guess it's always good to have any documentation than nothing.

I have two hopes here:

- when developer finds a problem with migration, they look there.

- having a document that I can point when one of this problems happens.
  What I do now is that I write an email, normally of worse quality and
  not finding a good example.

> Acked-by: Peter Xu <peterx@redhat.com>

Thanks, Juan.


