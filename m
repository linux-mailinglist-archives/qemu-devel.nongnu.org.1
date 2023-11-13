Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E006F7EA1E9
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 18:34:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2aov-00043q-AP; Mon, 13 Nov 2023 12:33:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r2aoq-0003uO-LO
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 12:33:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r2aoo-00012A-Vd
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 12:33:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699896829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M+ajEDqOMokRKLJX+iE/ssDqmDKkfhEBdwRiev2YuvE=;
 b=QZ51kcRlVNDDpOmORyghmPFnP6c/eMz1jBSqAc/bfa3LH1KqGG84ONrUfAcs7AY3eNQvYk
 BtorgFgk0OpDZUfjfOYb2h/9JD09mqf5IDLkuDh/CY2qjFo2Aajwbjzht+e1genAGfFwzS
 qedfYSQ1Mb/Wuf4TJxMwVASmheoOLwM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-yRlTWkGrNnaNwZB1id626Q-1; Mon, 13 Nov 2023 12:33:48 -0500
X-MC-Unique: yRlTWkGrNnaNwZB1id626Q-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-66cfa898cfeso5170576d6.0
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 09:33:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699896827; x=1700501627;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M+ajEDqOMokRKLJX+iE/ssDqmDKkfhEBdwRiev2YuvE=;
 b=fh/RHxieUyR8mf4rfwUjdjiWaCHvPe3rEUUcz+5mfilVLMiHXX/8YlKkZrKsgEZvCR
 8Go88AGBzQ1cLWl0YVA2Ub3vb+hKUvThIjDP5um9jF9oo3aE/jzeDhHDiF/a/K65EoWb
 HwMWzgQz/UmYCbsycCoaupqFHtnSECEU+ybBpWiFVG5az8oMRNra1mSN0ieYyJtz3oQp
 aUbVqyuXt1ViU3aT5YAjXZ/jxShDDlroOMDe/vLBxXeX5ANXEDMI6vt2YWC57hyESISj
 xo94eFL5G50F92UIPg7oiPAc3mjCgybsVNWON6IybQ+56HaaQ0mCww2OkU67LR2YgSHO
 ITkQ==
X-Gm-Message-State: AOJu0YynKvMf/+pMOKDb8wxpcMHNbrnIuMXNpFWaihqDuftvPkJGBVmU
 CKQAPEUJnUTwcJ0KK3XZQuedUWVNqIehulCI7Jx1pi8c/rdZKA2ldwNv7PPaY7x5LnTLfFYamy1
 7E/icmGzTyRfsS1M=
X-Received: by 2002:a05:6214:2f05:b0:671:9945:7a36 with SMTP id
 od5-20020a0562142f0500b0067199457a36mr8360919qvb.1.1699896827546; 
 Mon, 13 Nov 2023 09:33:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGgBj3H8RSDfSJE64LzdBf1E7boCuOcF+aXs2CCnNqmZhSnycfKF5qHJvgFJPjhbjUb8znMHg==
X-Received: by 2002:a05:6214:2f05:b0:671:9945:7a36 with SMTP id
 od5-20020a0562142f0500b0067199457a36mr8360906qvb.1.1699896827222; 
 Mon, 13 Nov 2023 09:33:47 -0800 (PST)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 g16-20020ad45150000000b0066d1bae2326sm2233927qvq.57.2023.11.13.09.33.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 09:33:46 -0800 (PST)
Date: Mon, 13 Nov 2023 12:33:44 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [RFC PATCH v2 2/4] migration/multifd: Join the TLS thread
Message-ID: <ZVJd-KLuYh36ofGc@x1n>
References: <20231110200241.20679-1-farosas@suse.de>
 <20231110200241.20679-3-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231110200241.20679-3-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Nov 10, 2023 at 05:02:39PM -0300, Fabiano Rosas wrote:
> @@ -826,7 +832,9 @@ static bool multifd_tls_channel_connect(MultiFDSendParams *p,
>      trace_multifd_tls_outgoing_handshake_start(ioc, tioc, hostname);
>      qio_channel_set_name(QIO_CHANNEL(tioc), "multifd-tls-outgoing");
>      p->c = QIO_CHANNEL(tioc);
> -    qemu_thread_create(&p->thread, "multifd-tls-handshake-worker",
> +
> +    p->tls_thread = g_new0(QemuThread, 1);
> +    qemu_thread_create(p->tls_thread, "multifd-tls-handshake-worker",
>                         multifd_tls_handshake_thread, p,
>                         QEMU_THREAD_JOINABLE);

I understand your way of doing this, but personally I prefer bool and make
QemuThread not a pointer but still statically allocated.

Same comment to the next patch.

IMHO we can even add support for QemuThread in general to remember the bool
itself:

        struct QemuThread {
                pthread_t thread;
                bool thread_created;
        };

Changing qemu_thread_create() to set the bool, and join() to skip the real
join if it's not even created; clearing the bool otherwise after join()ed.
I _think_ it'll work transparently to existing callers, but start to allow
join() to be bypassed if thread not even created.

Thanks,

-- 
Peter Xu


