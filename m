Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E2AFB7B81E5
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 16:13:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo2bT-0001nF-1F; Wed, 04 Oct 2023 10:11:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo2bE-0001mo-E7
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 10:11:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo2b9-0001Z0-Ir
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 10:11:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696428694;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=NSvg31Q/uMUXuwBFyMj7dr2msIONUBx59eZp/JNT9hM=;
 b=QD715NWlRWabEyC/LtbC6RIu4p+p1zqA8MqOH7WGdYN5r6EavmjV283osu32MkvxPgPAnF
 VL0ZrDpB2ezIP+36qEKW74oN4OY5+vj+ya2KFFVzRCsjLg1Tje332C7nC67UuRVPtgCJ5o
 SyGYkDLqAq+xW1m+IK5HpqfkGq8xL78=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-2xxfQmn1ObKY1BkqZEtDNw-1; Wed, 04 Oct 2023 10:11:28 -0400
X-MC-Unique: 2xxfQmn1ObKY1BkqZEtDNw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40652e8cb57so16102775e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 07:11:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696428687; x=1697033487;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NSvg31Q/uMUXuwBFyMj7dr2msIONUBx59eZp/JNT9hM=;
 b=XHfXSUZUO3ngIN/Jy2Tn7xalhaI2IQea/YErn3gMV735RWwx4l8xDdkh7zEuKy+lPg
 5riOmzVRZDWYtr6CE6e9dEKazYhf3WMJVhspxriWo4FNucWSFpUoXLhTMJAhemASEyhC
 OXnhORFmcj78Uk5B24J9CPjoUXsYS2e1SZC/ayQPX2OTuchEfQiSdBVV9a7/4Xk9rMFm
 PVQJfEMJFa+8WeaN2t8coieRtmf9cY6+hWxQDS9Bsf5p+2XjPAfJtrf/aWjqtl8+rvel
 oywE3p/7T0hxdNTDWItaAqFQkOK8lzAT0HyywA/dB2qAkyF80PskhqW1pdpBUDPhatF2
 cJ8Q==
X-Gm-Message-State: AOJu0YwI+OIWL4QolWzYLHLtTcMkfc70VAZUfD8SzUKMtL5YIKBsUNNo
 2PhnMO7NI3BEGXNI3yhKrDxctyTnPSYEft0g5tQTq2qufO3wWhv9eDv+HT0Xs9D6+oXevLXu9cC
 dFglt+5DJvtR2WhY=
X-Received: by 2002:a7b:c4cb:0:b0:401:cb45:3fb8 with SMTP id
 g11-20020a7bc4cb000000b00401cb453fb8mr2369959wmk.38.1696428687330; 
 Wed, 04 Oct 2023 07:11:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVD89RSNe+wG/rz6mmOzxq3qS7ERmoLeaH73dFoVXoTsE1IXtPZ9/nx4Hwq20j0mjn1VtClQ==
X-Received: by 2002:a7b:c4cb:0:b0:401:cb45:3fb8 with SMTP id
 g11-20020a7bc4cb000000b00401cb453fb8mr2369939wmk.38.1696428686930; 
 Wed, 04 Oct 2023 07:11:26 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 c5-20020a05600c0ac500b0040586360a36sm1620107wmr.17.2023.10.04.07.11.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 07:11:25 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Steve Sistare
 <steven.sistare@oracle.com>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,  Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v5 2/6] tests/qtest: migration: Add migrate_incoming_qmp
 helper
In-Reply-To: <20230712190742.22294-3-farosas@suse.de> (Fabiano Rosas's message
 of "Wed, 12 Jul 2023 16:07:38 -0300")
References: <20230712190742.22294-1-farosas@suse.de>
 <20230712190742.22294-3-farosas@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 16:11:24 +0200
Message-ID: <87v8bm1nqr.fsf@secure.mitica>
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
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
> file-based migration requires the target to initiate its migration after
> the source has finished writing out the data in the file. Currently
> there's no easy way to initiate 'migrate-incoming', allow this by
> introducing migrate_incoming_qmp helper, similarly to migrate_qmp.
>
> Also make sure migration events are enabled and wait for the incoming
> migration to start before returning. This avoid a race when querying
> the migration status too soon after issuing the command.
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Juan Quintela <quintela@redhat.com>

queued.


