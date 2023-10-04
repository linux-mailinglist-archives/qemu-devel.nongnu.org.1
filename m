Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F4D7B7AF1
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 11:00:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxe1-0001tB-BU; Wed, 04 Oct 2023 04:54:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qnxdr-0001nz-C2
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:54:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qnxdp-0001WC-Ul
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:54:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696409641;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=f8Pdxz5NB++ZdUKgJUa0dO5X8QVngip2ALTnG0Uu3wk=;
 b=AkuNsaouoRTb5GfvDaJNEDPF0YDzNPYWb2s067u17ueS42STCOYGmqZId8NF3mU0+pfxgf
 osxenHMGe1kiQaGa6xFks2VPxF4qjN4OiJr3EWYbF+wpLvM/BvCaxOYL2kKCH8eTL/Wvnx
 jXY+S4l2aG+QVDiTlrVXl0cP9Z6ts20=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-_YB5XA1nOl2pnssi_cZZZA-1; Wed, 04 Oct 2023 04:53:55 -0400
X-MC-Unique: _YB5XA1nOl2pnssi_cZZZA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4067f186094so10863565e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 01:53:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696409633; x=1697014433;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f8Pdxz5NB++ZdUKgJUa0dO5X8QVngip2ALTnG0Uu3wk=;
 b=r+Jw8UNI5N3VksyTKRZfUAydgKduXZpZ4Cn4xlVlMX5vdCGzE2ygcxURZzqSmd2+tQ
 7uWvqw3u4Ygn223udLusmZkwHnsKzWC+2MEkMUb+H996OmY90AoBxqfc2XIJDcDW/f4S
 nJch8vFZLYhgueVlinPtDrM2ii7QIK/z27wa9Uf6dblIVTmcggFVdXMQ9cYzCxSOoNPI
 vLfuyCbJ8DeRiMRG6l5hUtVg6SddRy2qmHmC02U0yHZCcor1lfbg1ZztJgF7g2uWvocg
 lGscZZ3fCjmeI5yQ29NRDkhF3jO/U7p+ZXh3h0DO8Ee9xpoEjDn3FasnvwUOF1hc1C2R
 BuuQ==
X-Gm-Message-State: AOJu0Yzr6GLPgFS0b9ntKmaa3sgYVPO+3g71UEDPb2kZt88kRgofxMp9
 iJBF6rhR9lK2mfxwFUXdVnkVKmlQ7jwgRlyhmlOQ2OrYavQy8HMksHrdo7kmQtEapp6i/TYCI08
 T9ygrkkREGYZ7gOhtRbpmnNHrZA==
X-Received: by 2002:a7b:cc07:0:b0:401:73b2:f039 with SMTP id
 f7-20020a7bcc07000000b0040173b2f039mr1914864wmh.7.1696409633426; 
 Wed, 04 Oct 2023 01:53:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdbWElfXNnf6KFK5mSuteMCby6Hk50FgBe6YjdOzFNIBCwfNQZ+lsdlZ8iIe7Km4upQ6lwGA==
X-Received: by 2002:a7b:cc07:0:b0:401:73b2:f039 with SMTP id
 f7-20020a7bcc07000000b0040173b2f039mr1914853wmh.7.1696409633211; 
 Wed, 04 Oct 2023 01:53:53 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 m7-20020a05600c280700b00405391f485fsm946177wmb.41.2023.10.04.01.53.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 01:53:52 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc: Peter Xu <peterx@redhat.com>,  Leonardo Bras <leobras@redhat.com>,
 qemu-devel@nongnu.org,  qemu-s390x@nongnu.org
Subject: Re: [PATCH v2 3/3] s390x/a-b-bios: zero the first byte of each page
 on start
In-Reply-To: <20230919102346.2117963-4-d-tatianin@yandex-team.ru> (Daniil
 Tatianin's message of "Tue, 19 Sep 2023 13:23:46 +0300")
References: <20230919102346.2117963-1-d-tatianin@yandex-team.ru>
 <20230919102346.2117963-4-d-tatianin@yandex-team.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 10:53:51 +0200
Message-ID: <87jzs24vkw.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Daniil Tatianin <d-tatianin@yandex-team.ru> wrote:
> Same as with the x86 verison of this test, we relied on the contents of
> all pages in RAM to be the same across the entire test range, which is
> very fragile. Zero the first byte of each page before running the
> increment loop to fix this.
>
> Fixes: 5571dc824b ("tests/migration: Enable the migration test on s390x, too")
> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>

Reviewed-by: Juan Quintela <quintela@redhat.com>

queued.


