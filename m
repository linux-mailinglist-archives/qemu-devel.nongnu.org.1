Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0A57B855E
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 18:33:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo4oD-0004RZ-B2; Wed, 04 Oct 2023 12:33:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo4oB-0004Mk-6j
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 12:33:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo4o9-0001uG-NP
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 12:33:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696437188;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=RM59J6QL5gIVh1B59g1i5XixKsI4dyp+XF/EED2/pRA=;
 b=UZnb2d8IgUGvxx42EEFZZo9rnlIm9rxsdtE9UvpRuH3nr9oVl7ZRF3wN2y/esuPKNEMGjV
 s7SSMdJ9xeIwg4YaArAdMCdk6TwjCBF1aKjRf25jjBEVx3yobGcKlzLQbV7rKT7GCa2chr
 fzZ3KBaE3tyUVZbLsP+QBwkBG2mUCq4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-6gfrG7p4MzOVJaXniudb0Q-1; Wed, 04 Oct 2023 12:33:06 -0400
X-MC-Unique: 6gfrG7p4MzOVJaXniudb0Q-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-32006e08483so35913f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 09:33:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696437185; x=1697041985;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RM59J6QL5gIVh1B59g1i5XixKsI4dyp+XF/EED2/pRA=;
 b=GxJcbXQ/xKWmLSmxP/0Uvb+khAdaNurj7n2Td7a+Jiw/OZ/c07rmKr6FjgaDYeS8IF
 us5Nhr86oYpoFXSyyQWQAHWJ6kc8t/zV2aitCwdVlJ1CjRys61fiPwKj/y+fVYVyyLw8
 taBvwyx8ivRV8yxm49sxD4gBJsYZA/QrPntWeImNovqJdquEs4RH6r6EdEgLTkSSWr1L
 2tyOnFMp8JwwtwculvLQpWhi/RU4sICTG/zdUNRpL7MTxoDQsbn6o1oE3FXPFdxR11NG
 lsFl2iQ57cpLGXPYLqpCEf/eIy5DS2OcjAB9H8xGAr/Nqe3WfPzLM0Ypg4laDmNTqQqv
 3QTQ==
X-Gm-Message-State: AOJu0Yz2vWDm6XtepPQyO+TzWV4FhZMmr2fJDO2t9HC6MV78/JfA29iK
 vPouuSnGXQmMdwhKhEBQwsiq08GJR//aSUvBkqXuY/PHEZ/1alYXvaQd4ik4HJsKub6a5mL8636
 kLF4aSd1Kg9snpEsdwcSW92ndPA==
X-Received: by 2002:adf:f683:0:b0:321:5141:5523 with SMTP id
 v3-20020adff683000000b0032151415523mr2417473wrp.67.1696437185049; 
 Wed, 04 Oct 2023 09:33:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzXmCDHLGKRDATd4IEZoGlw2SIxD5XGzQ4+qGta3xA+iPiAv9vpBFfM+SBuc7mjXdAl23nUw==
X-Received: by 2002:adf:f683:0:b0:321:5141:5523 with SMTP id
 v3-20020adff683000000b0032151415523mr2417456wrp.67.1696437184717; 
 Wed, 04 Oct 2023 09:33:04 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 da4-20020a056000196400b003279518f51dsm4436035wrb.2.2023.10.04.09.33.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 09:33:04 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  leobras@redhat.com,
 farosas@suse.de,  lizhijian@fujitsu.com,  eblake@redhat.com
Subject: Re: [PATCH v2 29/53] migration/rdma: Check negative error values
 the same way everywhere
In-Reply-To: <20230928132019.2544702-30-armbru@redhat.com> (Markus
 Armbruster's message of "Thu, 28 Sep 2023 15:19:55 +0200")
References: <20230928132019.2544702-1-armbru@redhat.com>
 <20230928132019.2544702-30-armbru@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 18:33:03 +0200
Message-ID: <87cyxuuz40.fsf@secure.mitica>
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
> When a function returns 0 on success, negative value on error,
> checking for non-zero suffices, but checking for negative is clearer.
> So do that.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


