Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE1A7B8E3C
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 22:41:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo8g3-0002Ed-TG; Wed, 04 Oct 2023 16:41:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qo8g2-0002EV-Im
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 16:41:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qo8g1-0005Ax-43
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 16:41:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696452059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QUR9knr0ESUx7lraU5Zh9bIE+S6bv7QTkQyk1cDRVjQ=;
 b=TxaQ163cTz6BylmmMwTD50ePJ7pO7PbB+oe0NXd/q0gkyc3NNgyFeB0uWaKHWs+RDXzSux
 4c9A2ERVEUndjr6bYyEjHqLf0nf04XIDkE1lu/pNym+9VRRZL66mCgwVduXRWTDM1c5Wlj
 Xrr1UtPZYpJoaEIBm++Pf65VMn0m6uE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-xBU50tBmNKiAfhcNvgKwGQ-1; Wed, 04 Oct 2023 16:40:52 -0400
X-MC-Unique: xBU50tBmNKiAfhcNvgKwGQ-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7756d0fb11dso7836485a.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 13:40:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696452050; x=1697056850;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QUR9knr0ESUx7lraU5Zh9bIE+S6bv7QTkQyk1cDRVjQ=;
 b=lunRQ8Go2jet8CKEMiwKRTscSVXLfADxRiTIhhWp+tCzOZEW7/uNqegmYaEXpPygyN
 IO3xsdhB0gWSZ4AVwf16qNgN90lKMFSAFOzJ5lleInPaI1MMcz6pR3Y9qEpvehLneONs
 kuKKtO0PGzKPtKh9Su1gvsJpNyCnRk1gfl1PeJ15Y0KSNDkn3DUcVVsxW0VbXVK5aZqi
 JBdCpRRydEuaE8c7qfw0cOM4OCDfrVbO6a66pIZI4n96Uw3iHyk2LSXhaZvS2zslszvE
 RfsjT3tIh6ahAkBqTn58OypAIVhe2f2n/4ZPb6trJ8gmCFygEsAv+3fAjGSo4cBRp3jX
 JDOw==
X-Gm-Message-State: AOJu0Yxd/KdeOxr0ZKbZX3CYtZ0bJrU0mMcyIzoay+b5QRyiotWgqjGX
 e8XgiYf5xbdDpE5NfE2PBTfl4nlyiKrnn7B9Qkt5I55noD5Cy19TpLrZ1Ofcc5uEg5D40wSHSyE
 RWnHMn84v5UukyRc=
X-Received: by 2002:a05:620a:31a5:b0:76f:167a:cc5d with SMTP id
 bi37-20020a05620a31a500b0076f167acc5dmr3894919qkb.7.1696452050747; 
 Wed, 04 Oct 2023 13:40:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDEDTzradbKpL0TUm5RYoUDxKVVpaBBufQJR/qjaHT4BsfBBETjpTbjvSquimB7V48+97EHw==
X-Received: by 2002:a05:620a:31a5:b0:76f:167a:cc5d with SMTP id
 bi37-20020a05620a31a500b0076f167acc5dmr3894898qkb.7.1696452050424; 
 Wed, 04 Oct 2023 13:40:50 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 ow20-20020a05620a821400b007757eddae8bsm1513422qkn.62.2023.10.04.13.40.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 13:40:50 -0700 (PDT)
Date: Wed, 4 Oct 2023 16:40:43 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] qtest/migration: Add a test for the analyze-migration
 script
Message-ID: <ZR3Nywj7Ymoi2kvH@x1n>
References: <20230927214756.14117-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230927214756.14117-1-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, Sep 27, 2023 at 06:47:56PM -0300, Fabiano Rosas wrote:
> I know this adds a python dependency to qtests and I'm not sure how
> much we care about this script, but on the other hand it would be nice
> to catch these errors early on.
> 
> This would also help with future work that touches the migration
> stream (moving multifd out of ram.c and fixed-ram).
> 
> Let me know what you think.

The test is good, but I think it'll be definitely less burden and cleaner
if it can be written just in shell scripts.. that can even be put in a
single line..

$ (echo "migrate exec:cat>$IMAGE"; echo "quit") | $QEMU_BIN -monitor stdio; $DIR/scripts/analyze-migration.py -f $IMAGE

Any chance to hook that in?

Thanks,

-- 
Peter Xu


