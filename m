Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 329929E78E1
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Dec 2024 20:26:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJdxe-0007wW-8J; Fri, 06 Dec 2024 14:25:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <1263914829+auto_=qemu-devel-bounces+1263914829=qq.com=nongnu.org@qq.com>)
 id 1tJdwr-0007kF-9M
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 14:25:10 -0500
Received: from out162-62-63-194.mail.qq.com ([162.62.63.194])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <1263914829+auto_=qemu-devel-bounces+1263914829=qq.com=nongnu.org@qq.com>)
 id 1tJdwm-0004DN-I6
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 14:25:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1733513097; bh=Tya4X6xk2Em9udC+qAiV7Z5rR3qPi1LdIgzkmCpXaXk=;
 h=From:To:Subject:Date:In-Reply-To;
 b=d6E5n4bHZNJAoh/AcGZc6PFii2yXetX0F384ctcXxHWSfcumpSwNobQ0JV33GAgOC
 G6N8/MlLX4Vl2K2092ALOQ84q3PzwEWLSKU/n9XmE2suWujDrVU1teIcsvkIVq/dbq
 UPA3alfY55kXRq1WurjGgZh8xIssw1i9OKFT9rVE=
X-QQ-XMRINFO: NmyfvsrRkCkJS5MlOxeZYe4=
X-QQ-XMAILINFO: OPDQNGCUQ3qL7oMS0bynkytkblMJhdgv4C/+AzHiF9DaVEms5v2YgEhUwSkLJr
 geM8RwUGt95Ep+Mq0h6vdUD1jrvP/wtz/HamEuzleh0ABd//cpHyK28SZZKjOYz9rjzCKNYQU1Rl1
 IKGsoApuP6lpFcWWb2WKfd7QwbfJWcsASFfRhtALT4ZevB6i5VDcnv9c0wwqm+q7bFhGbDq0SZYMh
 i45ZAS6AhxQfdDm91JC1+SnDNtrbcJAHXxmQ2eXqNuSALnHjZuzPniytODCqnWCGK5tsHrBOv3l5A
 0PJWpKz4Rk8AnakIWfD653bkVkUFO/Xr6CK5Z8wG7GNeKqMChGYsgAaFNXmoxKgkQAOKfeShLLQ7h
 E3DNUEzHDFPNKUdJUC0U1S9fdI01QiXpPy6/z7q/whIS4zKm9ayeZCyBWbg2wCJiv77ulJiZKSEYL
 mSAMysUHOB0UnrSBFV7oHogZCzd84KQTH0Q0CEcoNearria6xTEVhXEs7915BmCGim8GN4M4OB99l
 QFplYnO7JIvLe6PvOgS2eVAvkIgH5pCrKxiB39qAHYF96q1ByguhxjUwTikR0hMOOxg7PGmWV2w/2
 dtebNshRE6T3ZPJI5dkTVoAi9hWHQqabnzblHCVhLESPStohZBWalEovb2YEVzJ7q1In4GCHtRvBI
 /Z0lAxGgiCz7Q9wT4RS7xTOUojin3EaDE9e6kK3Yn4+Chse3MxTT9oOIZTprzMPHjIKi4/v7jTWHy
 muNx8wWeIwKlt35tA7ZndgN5Eog2XCz8jyMLGPGG1Q+mz1drm1VLXUAV47SD5jhhn8bAm0lyudLsq
 RNJKcE9U0xNFQA0MJ1Zkh8FscjzlG/lS06L+lwSwg6ASguRF2uqyAFHDJeARobK6Ec8VlmP47Znea
 kiJiKTwRUpWpyGKINmCL27GpOQXWnT+D5IAq8iAHj61hzJHQr8uuz/JOkQcp9gHqpdi4rauBDg8nV
 NSI7yYSQLo7t4pC4A5tywOBsnwzqBexxQTCfcOIpByIiVt+kaypiZcdTT5lOsGxzhlumimhPBGx1p
 gy/Unqto6IvnkoXHpfmmiMBiX9Vr+PjM0dD+S
From: "=?utf-8?B?MTI2MzkxNDgyOQ==?=" <1263914829@qq.com>
To: "qemu-devel-request" <qemu-devel-request@nongnu.org>
Subject: =?utf-8?B?6Ieq5Yqo5Zue5aSNOiBRZW11LWRldmVsIERpZ2Vz?=
 =?utf-8?B?dCwgVm9sIDI2MSwgSXNzdWUgMTA1?=
Mime-Version: 1.0
Content-Type: text/html;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Sat, 7 Dec 2024 03:24:57 +0800
X-QQ-AUTO-REPLY: true
Message-ID: <tencent_52ADA4817628A99F27EB0F1A@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
In-Reply-To: <mailman.71.1733512988.13763.qemu-devel@nongnu.org>
X-QQ-mid: rexmmxzc23-1t1733513093ts3s4mw9d
Received-SPF: pass client-ip=162.62.63.194;
 envelope-from=1263914829+auto_=qemu-devel-bounces+1263914829=qq.com=nongnu.org@qq.com;
 helo=out162-62-63-194.mail.qq.com
X-Spam_score_int: 46
X-Spam_score: 4.6
X-Spam_bar: ++++
X-Spam_report: (4.6 / 5.0 requ) BAYES_40=-0.001, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_EXCESS_BASE64=0.001, HELO_DYNAMIC_IPADDR=1.951, HTML_MESSAGE=0.001,
 HTML_MIME_NO_HTML_TAG=0.377, MIME_HTML_ONLY=0.1, NO_FM_NAME_IP_HOSTN=0.001,
 PYZOR_CHECK=1.392, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_DYNAMIC=0.982, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

6L+Z5piv5p2l6IeqUVHpgq7nrrHnmoTlgYfmnJ/oh6rliqjlm57lpI3pgq7ku7bjgII8YnIg
IC8+PGJyICAvPuS9oOWlve+8jOaIkeacgOi/keato+WcqOS8keWBh+S4re+8jOaXoOazleS6
suiHquWbnuWkjeS9oOeahOmCruS7tuOAguaIkeWwhuWcqOWBh+acn+e7k+adn+WQju+8jOWw
veW/q+e7meS9oOWbnuWkjeOAgg==


