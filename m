Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 618E271FB53
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 09:47:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4zUI-0006ZP-3s; Fri, 02 Jun 2023 03:46:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q4zTm-0006X9-3L
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 03:45:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q4zTe-0001UC-6h
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 03:45:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685691934;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kbgX5ZIPKhX3Fnvw1qmeJAf5GZFn9j/bqv4l+yOsqN8=;
 b=SGcil+KA/P+Pbv0FJmvdPa7smFI0ytp5W2IlRD44dAlKXUr4ilmdeiBODSv2McAY2/Tgju
 iyouM9+R6rFwbNFNp5gJmiW4CE8zeny+2G8dXAmDokTDF5wybSewrvd96hXmRSfgLwLp8q
 MZJ5LtFCfF/8+7Y8eXyYfoIYsGEFFhg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-S52h6bTIOBiKYeB7jeAXNg-1; Fri, 02 Jun 2023 03:45:32 -0400
X-MC-Unique: S52h6bTIOBiKYeB7jeAXNg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-30ae7bd987dso834986f8f.2
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 00:45:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685691932; x=1688283932;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kbgX5ZIPKhX3Fnvw1qmeJAf5GZFn9j/bqv4l+yOsqN8=;
 b=Q/zquTtUZOPb3f/EY1jGp+x3uKy6y6gxLHkaf0kft4+9FrXBi0Pyq0C85R7UeGzjpi
 t2L3X65Aal+9LxpuPxSkaQkcozeTMEVkD2Mskv0W0xyAzW9XDMP4SKPSJV4YKTl09yDw
 SXh8HROJfcIjaLoUVUy3WDk6YyRz6fPUkvkbFswrvQj2Sn8zamVmDCVTdJftoV5j2o+F
 PRCfrEZOJtxHBOaasJFba2a+U4I/GfLe+isq+W/pZdJwG5L7l21ATa715tacnWVNYXMK
 JISTlIpa7+MjJyz+/ZmFIqJvvNK12JSJ+3ISGWHSN37s0hp653SOtZ8r01U+Bt6UQF1u
 vNfA==
X-Gm-Message-State: AC+VfDxNN2/ubB1oBuf34bzH/oUHWsIE5WhIlGfD9FlryL97L5kgy5m8
 nIvZQAQ03pH6H/Y6kJnXN9nGgR7RKPxqKw+Y8twK9PClbNIk8oBVrsavqx4eREqByWZpJo8HXQI
 FWaePZ4Fnh8PV0Kg=
X-Received: by 2002:adf:e846:0:b0:30a:efb0:ce5c with SMTP id
 d6-20020adfe846000000b0030aefb0ce5cmr3696589wrn.45.1685691931914; 
 Fri, 02 Jun 2023 00:45:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4has+QFCrf3Wba/3YD57IZaUfxdd80Sm+HZyzb2J39rgC/x+rzx+LZn1MPXhFNrUfmV5DFrQ==
X-Received: by 2002:adf:e846:0:b0:30a:efb0:ce5c with SMTP id
 d6-20020adfe846000000b0030aefb0ce5cmr3696576wrn.45.1685691931593; 
 Fri, 02 Jun 2023 00:45:31 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 d17-20020a056000115100b0030af15d7e41sm891299wrx.4.2023.06.02.00.45.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jun 2023 00:45:30 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Laurent Vivier <lvivier@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v4 07/10] tests/qtest: capture RESUME events during
 migration
In-Reply-To: <20230601161347.1803440-8-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Thu, 1 Jun 2023 17:13:44
 +0100")
References: <20230601161347.1803440-1-berrange@redhat.com>
 <20230601161347.1803440-8-berrange@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Fri, 02 Jun 2023 09:45:30 +0200
Message-ID: <87y1l2pasl.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> When running migration tests we monitor for a STOP event so we can skip
> redundant waits. This will be needed for the RESUME event too shortly.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


