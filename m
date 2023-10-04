Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C157B8285
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 16:39:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo323-0003OC-Kf; Wed, 04 Oct 2023 10:39:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo321-0003EB-U6
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 10:39:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo320-0004o1-GE
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 10:39:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696430359;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=80vpaG9giZ+9chKO9jq+4k10uLY00sMleWR3B7vIJb4=;
 b=WN4i0SU4Fm3laHOZOvv+HkFiAE0wtvFx0xrJC2cK4XPWgKVhbizPwTX/OtQ/A6FdE7tyPW
 4uBoqpHfV5PJfSQKOYk1PstfFimWFWXiu4HvenllEROQO0W4sx/+H5KFW0ZerB0C9F9yV4
 cStgkL94VXtNQGyyy8ZCh0XuG3rtBHc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-VjbnWgtrMsK4y5nzWtzpRA-1; Wed, 04 Oct 2023 10:39:18 -0400
X-MC-Unique: VjbnWgtrMsK4y5nzWtzpRA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4063dd6729bso17228425e9.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 07:39:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696430357; x=1697035157;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=80vpaG9giZ+9chKO9jq+4k10uLY00sMleWR3B7vIJb4=;
 b=CuNpJklg6l5Sngcr7ve/Gs0dYSizBY0Mg+//Ilim6ReMaiM5IcMb5LvixPKUGxac0E
 zgivxEiklUTOl1DzjzNKR+x+3xe+WJ2z3oEMnTxoBo4LoYDFxnidikqWhoYF4ZH7odzJ
 a31GB1QNzj7CDZCEMgFB7Uivnry++IuVpZA4iGYlTn2F05+cYxC50hvuKvPaiUJgocEu
 M2z+x7ZgPp0Rc0kgZNfK5aOHN0x3119DkhABUxlEc5qfmXfr9l2HpwxSKOArOu0o9rit
 v8zL9tekQMQrXHRn0XiEntUyqtzcXmlvTPl8Wq1hPOivWNDoAZM5k/JLEwC4Egxo3hLJ
 JTtQ==
X-Gm-Message-State: AOJu0YyoB1W3RY32OYUEqlKu7zk2G7CMzA3pSe1NFFZokwFVl0vVWMBO
 jTCKpg6Ggn5zukn+kbDckaCXuKa3J/00qSYJGMWaBhO9N6ZgQVr9xeS8b9RF/TsBf+FDzGkn4oT
 HV4wQxe4OszDpO80=
X-Received: by 2002:a7b:ce98:0:b0:401:bf56:8ba0 with SMTP id
 q24-20020a7bce98000000b00401bf568ba0mr2724218wmj.28.1696430357090; 
 Wed, 04 Oct 2023 07:39:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGv1u8AkopAkmndfABWTYgZ7603OtOFBL+spjC5a9gpJ8qjTxRbr86Si+WP443R4ioLIX3jeQ==
X-Received: by 2002:a7b:ce98:0:b0:401:bf56:8ba0 with SMTP id
 q24-20020a7bce98000000b00401bf568ba0mr2724203wmj.28.1696430356783; 
 Wed, 04 Oct 2023 07:39:16 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 z7-20020a7bc7c7000000b003fee567235bsm1708389wmk.1.2023.10.04.07.39.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 07:39:15 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  leobras@redhat.com,
 farosas@suse.de,  lizhijian@fujitsu.com,  eblake@redhat.com
Subject: Re: [PATCH v2 05/53] migration/rdma: Consistently use uint64_t for
 work request IDs
In-Reply-To: <20230928132019.2544702-6-armbru@redhat.com> (Markus Armbruster's
 message of "Thu, 28 Sep 2023 15:19:31 +0200")
References: <20230928132019.2544702-1-armbru@redhat.com>
 <20230928132019.2544702-6-armbru@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 16:39:15 +0200
Message-ID: <87pm1uzc30.fsf@secure.mitica>
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
> We use int instead of uint64_t in a few places.  Change them to
> uint64_t.
>
> This cleans up a comparison of signed qemu_rdma_block_for_wrid()
> parameter @wrid_requested with unsigned @wr_id.  Harmless, because the
> actual arguments are non-negative enumeration constants.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


