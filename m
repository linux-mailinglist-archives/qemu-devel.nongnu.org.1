Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 722727B828E
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 16:42:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo34H-00089X-FX; Wed, 04 Oct 2023 10:41:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo34D-00089D-RV
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 10:41:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo34C-0006ER-Da
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 10:41:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696430495;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=78T+Dem42SS4Rw+LbPuSipdXF1j8Z7RLiac19RS8CI4=;
 b=BTBgwwjgRUClLmrq7LKV/ROg2YUUFqo0KQ6b52abYIQyHclGaB3aE47yNJCI8d4F+T1S5F
 m+Ce6v7xBbgBMUWDB5lkMl90B8hL5zpzbGsLcTU2XT/ExXS7eIaUDtlFShqhSPZ5NGB4ei
 8rGafozTADDFAGZNMcoPYwx37omakVc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-Rj27jCMKM3OyaNN8Z4bpCA-1; Wed, 04 Oct 2023 10:41:33 -0400
X-MC-Unique: Rj27jCMKM3OyaNN8Z4bpCA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fef5403093so5462225e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 07:41:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696430492; x=1697035292;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=78T+Dem42SS4Rw+LbPuSipdXF1j8Z7RLiac19RS8CI4=;
 b=Bk3BozTpmC+C3fKPnfBzOZDk3R2Vi7m5VqyOJiYLYxF4Wi/NXiMzCDQ2wUeAyMtS+2
 +b80RL5Ocho0XyIcbefDITd+S+gCRD27mCBiB+hnk9SB7eu7MhtS4JYnLxtoRFHU7Hpy
 uP/ZLzVFFez3cAtELsKj4A+nTj+bkVKDoXhW5fZIBZG0BNDFhr2a9KTWurXvtFAnT+oB
 9VBzeqSgKvWPr3gh3n/ux2Bq7q5lanvrdSAye1kPPl6OU4VrfxgqGfqkTMw1ZwaXt0Vr
 E95TLEFDbWJxvmONEoTikJiNA7IqUnm3UUdgVgZjta8j7gHu4bmulqY56OZfNxfgOdgZ
 BriA==
X-Gm-Message-State: AOJu0YwGwUTbBa2sdT3/WWQvo3tnm3waopYSHDKYmVa57weN6byvbVof
 4M5+B5mIaEa5DyGMMDGcXQtccxXiH4fMYocSvzzEplcveWc4Ub8ypI4GQI69eTtYN67KUmfMwKP
 /SlSX9cNRwCV85No=
X-Received: by 2002:a05:600c:b4e:b0:406:80b4:efd5 with SMTP id
 k14-20020a05600c0b4e00b0040680b4efd5mr2188082wmr.14.1696430492584; 
 Wed, 04 Oct 2023 07:41:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtmWnWnKYFdYzjzMLpDbzooPDK/69Dc7XAmdTCE5wenY392y1FKm1oGvNMD/pkt/PNC9+yTw==
X-Received: by 2002:a05:600c:b4e:b0:406:80b4:efd5 with SMTP id
 k14-20020a05600c0b4e00b0040680b4efd5mr2188059wmr.14.1696430492161; 
 Wed, 04 Oct 2023 07:41:32 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 l17-20020a1ced11000000b0040588d85b3asm1700512wmh.15.2023.10.04.07.41.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 07:41:31 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  leobras@redhat.com,
 farosas@suse.de,  lizhijian@fujitsu.com,  eblake@redhat.com
Subject: Re: [PATCH v2 06/53] migration/rdma: Fix unwanted integer truncation
In-Reply-To: <20230928132019.2544702-7-armbru@redhat.com> (Markus Armbruster's
 message of "Thu, 28 Sep 2023 15:19:32 +0200")
References: <20230928132019.2544702-1-armbru@redhat.com>
 <20230928132019.2544702-7-armbru@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 16:41:30 +0200
Message-ID: <87lecizbz9.fsf@secure.mitica>
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

Markus Armbruster <armbru@redhat.com> wrote:
> qio_channel_rdma_readv() assigns the size_t value of qemu_rdma_fill()
> to an int variable before it adds it to @done / subtracts it from
> @want, both size_t.  Truncation when qemu_rdma_fill() copies more than
> INT_MAX bytes.  Seems vanishingly unlikely, but needs fixing all the
> same.
>
> Fixes: 6ddd2d76ca6f (migration: convert RDMA to use QIOChannel interface)
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


