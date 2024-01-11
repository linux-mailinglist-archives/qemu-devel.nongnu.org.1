Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF7182B404
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 18:25:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNynm-00005f-Bs; Thu, 11 Jan 2024 12:25:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rNynk-0008WC-6P
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 12:25:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rNynh-000794-Nm
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 12:25:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704993904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yx0qXcUBJwN4LNtTRsU8hKhpzp8VerROHmmUPukV3Lw=;
 b=dUEoo8koL09p4MxM4lgKMgOsPEy0AvObMeDXMHyDkjUXw+EYxr1PmzlRN6NCnEznls04Oy
 l7XLK+PeKzSLUeDC+GDIsx9i98PziUPVbNiH+n5Lf6NSyoxQQgzBpX6iVA+/7van+ZFtIW
 kpv1QYfCv5iq1JvsZ+iCodOWw6UYd0E=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-XkKEMlm5O2K0Soc-2F02Wg-1; Thu, 11 Jan 2024 12:25:03 -0500
X-MC-Unique: XkKEMlm5O2K0Soc-2F02Wg-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1d4a9860225so34735025ad.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 09:25:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704993902; x=1705598702;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Yx0qXcUBJwN4LNtTRsU8hKhpzp8VerROHmmUPukV3Lw=;
 b=uOMX6jb1Jz1Im1yWeUmBGOAXCwLUsx+zTRx6URrFBnTypJta4GimGqqkAASAhaLXed
 EpMqCUX6/fI+eSPouOw6nPLq/oBb+81RkaqdUGyaUp0raXhPSu5tscniWq/BY27+o2Hx
 hUNDfJ4bMGkJ5feCdpXZYkcSjF+9RBT3CJ/B6HwfkQOMR9eqZBEKckjTq9ZvdnV24Vbo
 99jvdEaPcLxv/zqq4hPpZaLPqMvNEYT/xGeO9xkxISAOBq7NMufukJl1/oa5RekeQsjz
 cGOTrKpIoFEoGbDRG7FfxpiR0ffd+v/q2Lw/pznGBzPoXNajhrrGs4caJzF5bqkf/F8s
 CcDA==
X-Gm-Message-State: AOJu0YyJFLN5eCh32PISpebJDOXn5WzZibBdasKii/u85a2GHAiq39xs
 E68M63rCrVE35oS1OUmyv9CEbdgQ6ER/Oln59jCBGrS1jJT3Xdqt5XCUmvS7Dea6I/xA77I99Aa
 Ndbu5WhvwGMtg79OEfazWuSHd1Lgtrmk=
X-Received: by 2002:a17:902:f545:b0:1d4:c7d5:3587 with SMTP id
 h5-20020a170902f54500b001d4c7d53587mr58341plf.9.1704993901689; 
 Thu, 11 Jan 2024 09:25:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF0fyeA4dziOv/U4LTrxAOMT7f/pIJsSrkXCpgQA2sZCbXYhyk4Idloo1ZY4yOcc/M7My+zcQ==
X-Received: by 2002:a17:902:f545:b0:1d4:c7d5:3587 with SMTP id
 h5-20020a170902f54500b001d4c7d53587mr58333plf.9.1704993901418; 
 Thu, 11 Jan 2024 09:25:01 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 mm4-20020a1709030a0400b001d05456394csm1414675plb.28.2024.01.11.09.24.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jan 2024 09:25:01 -0800 (PST)
Message-ID: <a8102d77-8dd3-4c3b-907a-fe2e94fb2d20@redhat.com>
Date: Thu, 11 Jan 2024 18:24:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/ppc/cpu-models: Rename power5+ and power7+ for
 new QOM naming rules
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org, Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
References: <20240111164652.908182-1-thuth@redhat.com>
 <20240111164652.908182-2-thuth@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240111164652.908182-2-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 1/11/24 17:46, Thomas Huth wrote:
> The character "+" is now forbidden in QOM device names (see commit
> b447378e1217 - "Limit type names to alphanumerical and some few special
> characters"). For the "power5+" and "power7+" CPU names, there is
> currently a hack in type_name_is_valid() to still allow them for
> compatibility reasons. However, there is a much nicer solution for this:
> Simply use aliases! This way we can still support the old names without
> the need for the ugly hack in type_name_is_valid().
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.




