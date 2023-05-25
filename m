Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89539710F20
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 17:08:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2CZB-00005u-T4; Thu, 25 May 2023 11:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q2CZ7-000052-Ry
 for qemu-devel@nongnu.org; Thu, 25 May 2023 11:07:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q2CZ4-0003Nk-SQ
 for qemu-devel@nongnu.org; Thu, 25 May 2023 11:07:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685027259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xRoW4dDC7DvKTwWX+D6GO+TsAZjNoqpnqSCk4yidiow=;
 b=H2c3btVmedK22JUZCw52nRJCBZlJIqyGKBMH1uFlF/l1oXGoFqyRCzdMyEhyCPbrcAL7ko
 xBBWCfSe9OyUAn9UJ4Hear32IRwmDCvBt+jzJ8+4wWUvXB/T3k1E2W9twRwsbaLmPc/6gO
 gb7UGBUddh0vaXVerXzyFacSUsJyxlU=
Received: from mail-qt1-f199.google.com (209.85.160.199 [209.85.160.199]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-42-KzdnSzuWMXeNtcQRDU_oFA-1; Thu,
 25 May 2023 11:06:31 -0400
X-MC-Unique: KzdnSzuWMXeNtcQRDU_oFA-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-3f7d72d552fso2224761cf.0
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 08:06:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685027185; x=1687619185;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xRoW4dDC7DvKTwWX+D6GO+TsAZjNoqpnqSCk4yidiow=;
 b=OGOg2r+WwO47ZaUJfBA0eG3gdHSckaZdy/SrSUUJdNJxef613lm35afV6buqdPgjEa
 xjVwy/4bYPqtqSpWlg56pHZ5/2brZA2O5TqKHVwzPUs4FLsx885S/eT83enU/Fzln0Kk
 i7QrC6+hoAbMN3TokxznsQcy6lUOCCfL3drX8pc2i9v5ME9bG/R4GrwGoSy6L9yalDG2
 zTXSneaOhizuEpGiO8+/cVIDPvlsILKodx4uFo0wCPf2qEp5lEr0KupyUSc3NzXZaCgP
 CUwhFSVfLVlGwe02qWdCCV7OnHLd0UsN8d6iyhZJvHsfG2ZZMu2X20ug+JwjW8y2sYl3
 Dmqg==
X-Gm-Message-State: AC+VfDwLCBev51dMG8PBQf24iA4fLX6qBSTLjC5vzernpawXTbxgu2BD
 N0Zo1m9snlJZ/YIjqECb08IaGO60k+2dWJFT5Bu+bLlr6HKiRjEUjjbNhC4CJaaNJa79MOEOslq
 GrkiAp9zkTYs6YsBAgTdZHio=
X-Received: by 2002:a05:622a:1a91:b0:3f4:fdaa:8e14 with SMTP id
 s17-20020a05622a1a9100b003f4fdaa8e14mr7629871qtc.2.1685027184938; 
 Thu, 25 May 2023 08:06:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5r3gTV7QLj7BODSanNWLqUz/DiOJuyADr3Yyp0hkDKNI9Y0adYryA6kE42wsu0y+FUvqWiYQ==
X-Received: by 2002:a05:622a:1a91:b0:3f4:fdaa:8e14 with SMTP id
 s17-20020a05622a1a9100b003f4fdaa8e14mr7629830qtc.2.1685027184521; 
 Thu, 25 May 2023 08:06:24 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca.
 [70.24.86.62]) by smtp.gmail.com with ESMTPSA id
 j21-20020ac85f95000000b003f6b8a6fd18sm450398qta.96.2023.05.25.08.06.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 08:06:23 -0700 (PDT)
Date: Thu, 25 May 2023 11:06:22 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH 2/2] migration: Put zero_pages in alphabetical order
Message-ID: <ZG95bpUJoiOX0mh1@x1n>
References: <20230504103357.22130-1-quintela@redhat.com>
 <20230504103357.22130-3-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230504103357.22130-3-quintela@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, May 04, 2023 at 12:33:57PM +0200, Juan Quintela wrote:
> I forgot to move it when I rename it from duplicated_pages.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


