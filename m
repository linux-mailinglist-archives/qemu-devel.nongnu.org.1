Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4F67B8241
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 16:28:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo2pt-0008CI-IV; Wed, 04 Oct 2023 10:26:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo2pr-0008C8-Vl
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 10:26:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo2pq-0008Jh-Iw
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 10:26:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696429605;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=7VGQ5opNOBxr48TXRQquNlGnMouVC1pzOcaHXlpbHAU=;
 b=Z777F+v9VYzJ5C3BhMQc7tKW+cEJWLgkUmHvvxZcVxR3nEEt66fdiG+gBDdySoI0Ljg+tF
 bgxDpstPg/jb8oiNTitR7SIOcJWwl8VAP3qslieqIlL0PcgimnuZ/f93j8964ctiD3KmzG
 sOGIr+NCm8AonSd9l9sZVG3u5wDByPM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-qOWx5wC2OGqDzxHJ_OUhQw-1; Wed, 04 Oct 2023 10:26:42 -0400
X-MC-Unique: qOWx5wC2OGqDzxHJ_OUhQw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3247f646affso494726f8f.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 07:26:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696429601; x=1697034401;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7VGQ5opNOBxr48TXRQquNlGnMouVC1pzOcaHXlpbHAU=;
 b=MHZ0rpnvm74LuesEKZscyocJ1u3B1k/NZo6NkOBElm0Fjh6NSN5gRvnNb3Pd4NBGMF
 tzQbTK0YB/ApaT5stuU955GkdzRcpZUokvoEYyvXO4X3s+cMO0G/azKeNvBAgpNOVR7e
 q/UUPN/AwB/sBq0Wu+c2wlZHpje5Rfb3dyKxLKBKTmW1/HxVa8L3AfHBY0Am0qMGMZTC
 DtmUl4gT9vz8svKrvQD9oTtuAvc1w8QzOM4UzW7EYjHh0yP9NQoNaM8Os/EcyGKnMeet
 y2DEgzdBTIOqlVbELQarQkfGbAyKsYeEhNlD6AF+p1vJI+VazdllvTPS7BzVDkbziniC
 Ub8w==
X-Gm-Message-State: AOJu0Yyz1CbxKVeh8omWyEeE98BFgATglstMyI9Typ9MTdOittnZfbCh
 ozdDBHU8r6G3inZVyGi/+CPUgdJowC9gpxTFht13i8FOawqYAjNfeDAqvQOgA2tnjXPya0zhDlT
 Kev2CLA/0HBGiTHg=
X-Received: by 2002:a5d:4fc6:0:b0:317:6734:c2ae with SMTP id
 h6-20020a5d4fc6000000b003176734c2aemr3990471wrw.11.1696429601706; 
 Wed, 04 Oct 2023 07:26:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxwYrpblE51Zr5EZDK9ZcYXcVfI1hf2eV2YoCqxbVprh4YwnS7Z+8MrHPAzxHRehfPXxeFxQ==
X-Received: by 2002:a5d:4fc6:0:b0:317:6734:c2ae with SMTP id
 h6-20020a5d4fc6000000b003176734c2aemr3990450wrw.11.1696429601393; 
 Wed, 04 Oct 2023 07:26:41 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 l26-20020a7bc45a000000b00405bbfd5d16sm1686421wmi.7.2023.10.04.07.26.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 07:26:40 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  leobras@redhat.com,
 farosas@suse.de,  lizhijian@fujitsu.com,  eblake@redhat.com
Subject: Re: [PATCH v2 01/53] migration/rdma: Clean up qemu_rdma_poll()'s
 return type
In-Reply-To: <20230928132019.2544702-2-armbru@redhat.com> (Markus Armbruster's
 message of "Thu, 28 Sep 2023 15:19:27 +0200")
References: <20230928132019.2544702-1-armbru@redhat.com>
 <20230928132019.2544702-2-armbru@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 16:26:40 +0200
Message-ID: <877co21n1b.fsf@secure.mitica>
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
> qemu_rdma_poll()'s return type is uint64_t, even though it returns 0,
> -1, or @ret, which is int.  Its callers assign the return value to int
> variables, then check whether it's negative.  Unclean.
>
> Return int instead.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

queued.


