Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4467B85EC
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 18:56:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo59p-00013u-UG; Wed, 04 Oct 2023 12:55:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo59o-00012L-5G
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 12:55:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo59l-0002PP-UP
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 12:55:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696438525;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=y5l9aOqnO3C4jcubNoCmuW7iPDeHGKck64HlQpMAmvc=;
 b=hap6KbX4Ny0YZlZsITsIg0i4e22BxlZ4yce2kPXo6RHpO0HVjncvsYiqcMZgooRVMh9Uxd
 n3x03/0/8b2RdrHOTR3J41xDSojEcuS6es7wlr7dH8MDndjYnraY1hA6c7AIAMLMAxymta
 kYhjdsYHm4NkWoFqNkyaGJTY3ERsH1U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-eIOy1Q-tOFe6eNn6mtFh3Q-1; Wed, 04 Oct 2023 12:55:24 -0400
X-MC-Unique: eIOy1Q-tOFe6eNn6mtFh3Q-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-32339eee4c4so60085f8f.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 09:55:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696438523; x=1697043323;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y5l9aOqnO3C4jcubNoCmuW7iPDeHGKck64HlQpMAmvc=;
 b=WBBAXcvOufkIEnRCaN+v4IpmIH5uVqDXbY5bMsMaU09nfKfAhyFtxFBJtAkxQkmWcX
 FmBZRSxALPTUE1j2yDgNGscXm06Wr+TLuKjNuUbfNcp08yaIA42ZHiYMxkEc0pUnsciN
 HOgT8HFe1F3t4ujbj6BixdW2h19nuOFEQ+Ke/zIwCqUeLzukbZWAIVEm2ZREQghwXGCa
 NrdLqyZwlZjpaN+DzNEuMaAya5fGvJiLDePKBptCF9ysIyC8IISbNeVa9MZLXL05FDQi
 s/Z0qEwl69+nQhkWXtc7iHe0K4/+oxC9nKJpqBjbMi1RswnV4qZiFEtZrYT6MHAC3hsC
 fnKw==
X-Gm-Message-State: AOJu0YzKjUIQkVsGca03lHiKvCbfiv51TMnvvHFtVD4D7oIuvx1S5ATV
 2WzqfzuScH1o/S3wprLlFVdis0Ou535qEmCbelOWWRaxJZecVwyjdk2e6o6M4DdWtNglXustxPA
 aECTNIo1q8180mlY=
X-Received: by 2002:a05:6000:109:b0:321:5d87:5f7c with SMTP id
 o9-20020a056000010900b003215d875f7cmr2709823wrx.30.1696438523370; 
 Wed, 04 Oct 2023 09:55:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFuizG5nanIEjf7aurJAFBpeKEpNj3Jjng1FSSInCNMdpJN+g5e7uKKeyw3YnNg2uUQk6WvQ==
X-Received: by 2002:a05:6000:109:b0:321:5d87:5f7c with SMTP id
 o9-20020a056000010900b003215d875f7cmr2709816wrx.30.1696438523169; 
 Wed, 04 Oct 2023 09:55:23 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 k6-20020adff286000000b00317e77106dbsm4412218wro.48.2023.10.04.09.55.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 09:55:22 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  leobras@redhat.com,
 farosas@suse.de,  lizhijian@fujitsu.com,  eblake@redhat.com
Subject: Re: [PATCH v2 37/53] migration/rdma: Convert
 qemu_rdma_exchange_get_response() to Error
In-Reply-To: <20230928132019.2544702-38-armbru@redhat.com> (Markus
 Armbruster's message of "Thu, 28 Sep 2023 15:20:03 +0200")
References: <20230928132019.2544702-1-armbru@redhat.com>
 <20230928132019.2544702-38-armbru@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 18:55:21 +0200
Message-ID: <87il7mtjie.fsf@secure.mitica>
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
> Functions that use an Error **errp parameter to return errors should
> not also report them to the user, because reporting is the caller's
> job.  When the caller does, the error is reported twice.  When it
> doesn't (because it recovered from the error), there is no error to
> report, i.e. the report is bogus.
>
> qemu_rdma_exchange_send() and qemu_rdma_exchange_recv() violate this
> principle: they call error_report() via
> qemu_rdma_exchange_get_response().  I elected not to investigate how
> callers handle the error, i.e. precise impact is not known.
>
> Clean this up by converting qemu_rdma_exchange_get_response() to
> Error.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


