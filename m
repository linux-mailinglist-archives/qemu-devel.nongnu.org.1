Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0E97EE4D0
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 16:54:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3eh1-0000qs-Ql; Thu, 16 Nov 2023 10:54:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1r3eh0-0000qj-FZ
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 10:54:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1r3egz-0007aE-5V
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 10:54:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700150048;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=4JWgz5JeU6+ln/MTNO/1H5Y6Gk0bdNJNcfAx5SNhKks=;
 b=X9hZcWQxw53UrWh2CV9ORAqYrMuBCTrOaXRYCTdA+YnC1EYEt80YMalTv8mFgJv5l6+Oi4
 V5w7BwDDA+P7NRs513OO0ifetO7ZPYXGtmFM1CRYIzIkySmSTFHPZaeYXn6zf4Oyyqwo7B
 HQwlvpmqQZyU9x9o+mPwP3qxXARqCCE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-ONNLWQvuO0uJ1SEwu8Mwxg-1; Thu, 16 Nov 2023 10:54:07 -0500
X-MC-Unique: ONNLWQvuO0uJ1SEwu8Mwxg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-408534c3ec7so5507115e9.1
 for <qemu-devel@nongnu.org>; Thu, 16 Nov 2023 07:54:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700150046; x=1700754846;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4JWgz5JeU6+ln/MTNO/1H5Y6Gk0bdNJNcfAx5SNhKks=;
 b=Y2jJMlT4G38UwedLANxVEtYjtjSgO+TqSsTyuDnK5YBHrqo+4uAXQQT2BZxXf8/KBA
 zz6XuZ9Nz9V8UiWBSNy0poO4K8PUcmSIxFV7Ttdt9VASUY90VWxA60NG7bEQn2AZVKcd
 Z8EHt4R3JChsLETw/OGSRpIGxJ7VQWATQwqQ+kFLkkBN5hH+QnBbtpt+QMF+8s8cibEI
 hlHQMuohfIUU1DqQPjHsyAFKmUa41jCA1I3uTIGiGzwjfC2GmgqdVZMeZ9R7eBOriRKS
 XRfMBYbkyQEbOhzCqaiBwLmub4R/It9Mn4cJZc6WxwKZaJ6J7BJeAZd/NziTZnbHMgtI
 j8OQ==
X-Gm-Message-State: AOJu0Yx/THV+5ZLI23PR6/8BEFUuZ3PJ0KTEvHQHs9eXWdrEPwSOgXyJ
 3vEfW7JUB7440RjqR6lyL6Q/AI7xzNpcvjjiHxfo9jkPisVL6kU6CG4Z/v6QkW6KWZhmdekmKqv
 vOXjSWrsPu2YUyGQ=
X-Received: by 2002:a05:600c:154e:b0:40a:55a8:2a44 with SMTP id
 f14-20020a05600c154e00b0040a55a82a44mr9408263wmg.22.1700150045903; 
 Thu, 16 Nov 2023 07:54:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEy58b131rQIWzs7vsCpXTJVgyXH5+2DUXciRcIrihYXd+ywVjwBuJ9nfEOEv49lrML0i2SAQ==
X-Received: by 2002:a05:600c:154e:b0:40a:55a8:2a44 with SMTP id
 f14-20020a05600c154e00b0040a55a82a44mr9408243wmg.22.1700150045576; 
 Thu, 16 Nov 2023 07:54:05 -0800 (PST)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 n33-20020a05600c3ba100b0040531f5c51asm4269147wms.5.2023.11.16.07.54.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Nov 2023 07:54:05 -0800 (PST)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [RFC PATCH v2 1/4] migration/multifd: Stop setting p->ioc
 before connecting
In-Reply-To: <20231110200241.20679-2-farosas@suse.de> (Fabiano Rosas's message
 of "Fri, 10 Nov 2023 17:02:38 -0300")
References: <20231110200241.20679-1-farosas@suse.de>
 <20231110200241.20679-2-farosas@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Thu, 16 Nov 2023 16:54:04 +0100
Message-ID: <87fs15hexv.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.117,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Fabiano Rosas <farosas@suse.de> wrote:
> This is being shadowed but the assignments at
> multifd_channel_connect() and multifd_tls_channel_connect() .
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Juan Quintela <quintela@redhat.com>


