Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C487AFE91
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 10:32:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlPy3-0001tf-TL; Wed, 27 Sep 2023 04:32:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qlPy2-0001tT-1w
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 04:32:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qlPy0-0008Lh-E7
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 04:32:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695803539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vnOrCYmZxuYRYX8kEmTsz0ChgYROOV0QSeJQZ6gWl5o=;
 b=XMCPNpJnJHbrlyu1wK7AxA481qOTGyBBv69bJaTmDUaL3MXIdQwd6NcMqpKULSIo2eRkSQ
 v7k/Irq3cYs4EdpR9S7nKRMWLMLICi7M3v7C0Y3ekS+BTYDzTVrj3pCALBR4ilxbT0xJPy
 mv3y9rJS074gwiJg9JX5vuhk3IXlfr8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-SWP4r7UnNgWCm4SkWeApTg-1; Wed, 27 Sep 2023 04:32:17 -0400
X-MC-Unique: SWP4r7UnNgWCm4SkWeApTg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-32320b3ee93so5430172f8f.3
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 01:32:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695803536; x=1696408336;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vnOrCYmZxuYRYX8kEmTsz0ChgYROOV0QSeJQZ6gWl5o=;
 b=a8suZ1DnOzNBL+Yx9fcpI83wnE6vBXAfEOqITQqtVKcGdsG9J1rWXfJPPYGplNTREc
 2Gu92GcTBYedV6zDKVuAyhUWdNdUJZWoD+3+GsKgGHAvniUlNchzUR8lTJxMrzkria9D
 LCfpiwgde2ZcKqNYQtZUTP7gI6RwEPQynj54ZTa0uWMi2b0Q3q6HVJmfJzL19SFTMY81
 /VrAw8FefZYorW3n9CXVUNJZlcz/OpicvXqgYB+2NA4EBLu1YgR4BiNJnGnsiE9Tgn9o
 5tMCiZkLpOlqZB/VAsHV8Y6ncFjIEecogHqgpQAYBfF9GfXfhScPh56cEs1XN3iGxwEU
 1fSQ==
X-Gm-Message-State: AOJu0Yw3ZEae1xa1ppeHX0QGLiu6HD9ZvZ6XmXqlsNAlA1ICun69cVWD
 rVJexTdb+fcYBZSUtgFqX0Tlg/trNLdzrKSuocE+eNhLICLfBO9uLCw6V32zzKbAe70TeWKtQfj
 G208ABomfT+75oCI=
X-Received: by 2002:a5d:630d:0:b0:31f:f893:e07f with SMTP id
 i13-20020a5d630d000000b0031ff893e07fmr1108649wru.12.1695803536329; 
 Wed, 27 Sep 2023 01:32:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyIoCzd2FD913ArR/1mC5ZnvSFC7O0Ps6j+3Rc945NFcK6saiagf7WafN/lib+Q0+TfmNEww==
X-Received: by 2002:a5d:630d:0:b0:31f:f893:e07f with SMTP id
 i13-20020a5d630d000000b0031ff893e07fmr1108633wru.12.1695803536012; 
 Wed, 27 Sep 2023 01:32:16 -0700 (PDT)
Received: from ?IPV6:2003:cf:d708:66e5:a5d0:fe92:2899:7179?
 (p200300cfd70866e5a5d0fe9228997179.dip0.t-ipconnect.de.
 [2003:cf:d708:66e5:a5d0:fe92:2899:7179])
 by smtp.gmail.com with ESMTPSA id
 v19-20020adf8b53000000b0032318649b21sm11384694wra.31.2023.09.27.01.32.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Sep 2023 01:32:15 -0700 (PDT)
Message-ID: <07282c72-7a83-70c5-395d-454281663eb1@redhat.com>
Date: Wed, 27 Sep 2023 10:32:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [Virtio-fs] [PATCH v3 0/5] vhost-user: Back-end state migration
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 "open list:virtiofs" <virtio-fs@redhat.com>,
 =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, "Michael S . Tsirkin" <mst@redhat.com>
References: <20230915102531.55894-1-hreitz@redhat.com>
 <20230925204852.GG323580@fedora>
 <fc005d50-03ba-0b8f-d9af-64a5297395a3@redhat.com>
 <CAJSP0QWwo6rqwY7F-OZgXBnRCLbF4C=66zLf35Jy43jKHebjDw@mail.gmail.com>
 <CAJSP0QWC1VsAr6k745cumQ7zehEYWRqY_0+gdj9ZtNuwZDNtAQ@mail.gmail.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <CAJSP0QWC1VsAr6k745cumQ7zehEYWRqY_0+gdj9ZtNuwZDNtAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

On 26.09.23 22:10, Stefan Hajnoczi wrote:
> Hi Hanna,
> I was thinking about how this could work without SUSPEND/RESUME. What
> do you think of the following?
>
> 1. The front-end sends VHOST_USER_RESET_DEVICE (or
> VHOST_USER_RESET_OWNER, when necessary) when the guest driver resets
> the device but not on vhost_dev_start()/vhost_dev_stop().

This is half the work of SUSPEND/RESUME.  It isn’t easy to do.

> 2. Suspend the device when all virtqueues are stopped via
> VHOST_USER_GET_VRING_BASE. Resume the device after at least one
> virtqueue is started and enabled.
> 3. Ignore VHOST_USER_SET_STATUS.
>
> Reset would work. The device would suspend and resume without losing
> state. Existing vhost-user backends already behave like this in
> practice (they often don't implement RESET_DEVICE).

I don’t understand the point, though.  Today, reset in practice is a 
no-op anyway, precisely because we only send SET_STATUS 0, don’t fall 
back to
RESET_OWNER/RESET_DEVICE, and no back-end implements SET_STATUS 0 as a 
reset.  By sending RESET_* in case of a guest-initiated reset and 
nothing in case of stop/cont, we effectively don’t change anything about 
the latter (which is what SUSPEND/RESUME would be for), but only fix the 
former case.  While I agree that it’s wrong that we don’t really reset 
the back-end in case of a guest-initiated reset, this is the first time 
in this whole discussion that that part has been presented as a problem 
that needs fixing now.

So the proposal effectively changes nothing for the 
vhost_dev_stop()/start() case where we’d want to make use of 
SUSPEND/RESUME, but only for the case where we would not use it.

Hanna


