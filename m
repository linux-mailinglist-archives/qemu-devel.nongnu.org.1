Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A42380C194
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 07:55:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCaCA-0002VS-5M; Mon, 11 Dec 2023 01:55:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rCaBc-0002V9-Bj
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 01:54:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rCaBW-0000Sn-Dd
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 01:54:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702277673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uFW3jaxWyaHIx48W5dFl2wUi5kqsbu1WbhO84+qj4QA=;
 b=MYiz6aN2nT3Uv9jzAf60pNhLyz815NA3Z2Wy7+X4GIei3s4eoZL8OhLLXsa2w8Mplr08pv
 O0wzzXwYraTPUPkIf+StN/xwXGza9NBjFNIl7f1zVJuIUBOy4T053q3rNBy+W6dcPV3mzK
 jqw4IZVzL3IG9mL9sfHL/JQOpWr5Mfk=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-ymh583dMMPGJQm_t2kjgCw-1; Mon, 11 Dec 2023 01:54:31 -0500
X-MC-Unique: ymh583dMMPGJQm_t2kjgCw-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-563de65ac5dso391420a12.1
 for <qemu-devel@nongnu.org>; Sun, 10 Dec 2023 22:54:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702277671; x=1702882471;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uFW3jaxWyaHIx48W5dFl2wUi5kqsbu1WbhO84+qj4QA=;
 b=ldfd09tUU/+Fl/TMAdn7WwX3FgnqjExVrWeL6mQPYMoDxDDlfE94UOWfsspbceAdBS
 P/YJ9UXxVdaQugp2KcTTc44R+iAMi0yQ9HyezCELwyAoirIgksAUjBoSE1LWK2Gtkbb0
 Gl/96osECFvAS2TjSuNSzklH5oDgfugq5KJCLe+9p9pjtj7v76ta+O0KvllPG2eSPoXd
 qwJ1dXA71YbOZpsRxBOqIhlU7/N8r5LokNaBJbYwxl4YRSUnjNoQr9ARbNOdGQJzBaUU
 ue7kojPSED6v0dGtp83jMlodSSLHOzOHTkbPWfnt95LIvGXlERpuceYrc6VQ/TAncKIT
 ekVg==
X-Gm-Message-State: AOJu0YzXj9Nm6g298d+bNVCJgA6Py1/1FGD4WMc96qqtuUllNmDhF8M+
 sis1vOCB6JEUWyaGQe4pqaQiOyoz/fZgCjpLfd3gCxpiJaUXWtqkM1AoHYB10SFgsPYDFC6jstw
 ez89/Jpd9R9f0m8c=
X-Received: by 2002:a05:6a00:2d9e:b0:68e:2fd4:288a with SMTP id
 fb30-20020a056a002d9e00b0068e2fd4288amr8363622pfb.3.1702277670821; 
 Sun, 10 Dec 2023 22:54:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFVkxOhZb5/RkWMqcomtXHd0n4TLm23+79J4oZ1laFZBnAphYAZSbSdVcDpbPtMDrvolU5heQ==
X-Received: by 2002:a05:6a00:2d9e:b0:68e:2fd4:288a with SMTP id
 fb30-20020a056a002d9e00b0068e2fd4288amr8363606pfb.3.1702277670480; 
 Sun, 10 Dec 2023 22:54:30 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 ka36-20020a056a0093a400b006ce7f0502f0sm5532056pfb.151.2023.12.10.22.54.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Dec 2023 22:54:30 -0800 (PST)
Date: Mon, 11 Dec 2023 14:54:23 +0800
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH V7 12/12] tests/qtest: postcopy migration with suspend
Message-ID: <ZXayH9Fox8kpCDgo@x1n>
References: <1701883417-356268-1-git-send-email-steven.sistare@oracle.com>
 <1701883417-356268-13-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1701883417-356268-13-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, Dec 06, 2023 at 09:23:37AM -0800, Steve Sistare wrote:
> Add a test case to verify that the suspended state is handled correctly by
> live migration postcopy.  The test suspends the src, migrates, then wakes
> the dest.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


