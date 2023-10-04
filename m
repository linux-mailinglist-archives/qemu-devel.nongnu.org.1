Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3D87B82BC
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 16:52:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo3EM-0000S7-NC; Wed, 04 Oct 2023 10:52:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo3E6-0000NX-8h
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 10:51:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo3E1-0001Rk-JG
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 10:51:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696431096;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ZjNbmLMa/oCzHShm1wP7Z7vLenThX0ib39GiSbFubZg=;
 b=dFua5Oa44Q/O1O96+xZXMjY1zaeyYCfYtpJ46XAiqqvSlfzlyVyvzNMQhcohcUab49FnCs
 T8PvqQWudGzBY/FHABt3j1OnVUSP0+viWsVNIOO3bLSqpmzxhMbh6QlM1ZxD4OCF5NYsAA
 +6HvqMKaNANNoaAZf9kVPDxxmXt2HNI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-K-qnOpdaPgG2RRfuWR6yaA-1; Wed, 04 Oct 2023 10:51:34 -0400
X-MC-Unique: K-qnOpdaPgG2RRfuWR6yaA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4066e59840eso15307705e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 07:51:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696431093; x=1697035893;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZjNbmLMa/oCzHShm1wP7Z7vLenThX0ib39GiSbFubZg=;
 b=RvwjZjSsKXB1VaKlwNfp2tszi8RZWE17bKyhjc+Tu0Tg6yDI4QDdNdeVp9k2TBUGYZ
 edKwlZE3X1HSd3hKP+IBLsX5yY4VtVHs9IKYJujfB5O+tQR2Vb8XD9i/3kDME9yXH3H0
 iD7+vvkrPMii23GR+KSZxYJ3bnBj5pVDcgIBGwKmQF5XWNKXil6PgNf89o/pG5FOw1C2
 Ee90JBq46954yNNUxW6aBVhT0ijfOHX2ps7f9mjBhtp6fR1kylYwptO6M1yJZ7slRI6b
 aGy8bF6yKO5SfJhYuVJQx9The3uwwK9SBL90GNvYZuwMeEqJF2XGBN3WBB2hPejV2BwA
 Ak5Q==
X-Gm-Message-State: AOJu0YwMkDUNsW7Zzv+Oo5G+5vDvTt7LGIPuj2wu3TP6QZfWNwoySPum
 Qei8Tt84AflpCtWTc0nvskWOonq/NKHggzv8QUtyuu5oi6KTR5UK2N5MgqkY0hB6GbXdUFhts9b
 iw+9UMEg009QpkNE=
X-Received: by 2002:a7b:c391:0:b0:405:359a:c950 with SMTP id
 s17-20020a7bc391000000b00405359ac950mr2517060wmj.19.1696431093277; 
 Wed, 04 Oct 2023 07:51:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuvF88C730t4OYfmqdKwXcn83tINlBnYPaw6T7Vp265BdKpME4jjpdqUZ0JvM7zUtRTdqMLg==
X-Received: by 2002:a7b:c391:0:b0:405:359a:c950 with SMTP id
 s17-20020a7bc391000000b00405359ac950mr2517045wmj.19.1696431093096; 
 Wed, 04 Oct 2023 07:51:33 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 m10-20020a7bce0a000000b00405953973c3sm1704299wmc.6.2023.10.04.07.51.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 07:51:32 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  leobras@redhat.com,
 farosas@suse.de,  lizhijian@fujitsu.com,  eblake@redhat.com
Subject: Re: [PATCH v2 09/53] migration/rdma: Fix qemu_rdma_accept() to
 return failure on errors
In-Reply-To: <20230928132019.2544702-10-armbru@redhat.com> (Markus
 Armbruster's message of "Thu, 28 Sep 2023 15:19:35 +0200")
References: <20230928132019.2544702-1-armbru@redhat.com>
 <20230928132019.2544702-10-armbru@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 16:51:31 +0200
Message-ID: <877co2zbik.fsf@secure.mitica>
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
> qemu_rdma_accept() returns 0 in some cases even when it didn't
> complete its job due to errors.  Impact is not obvious.  I figure the
> caller will soon fail again with a misleading error message.
>
> Fix it to return -1 on any failure.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


