Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7431073B670
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 13:41:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCf9S-0003xs-6V; Fri, 23 Jun 2023 07:40:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>) id 1qCf9C-0003wC-Jx
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 07:40:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>) id 1qCf91-0004xu-MP
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 07:40:10 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35NB6Vlg023885
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 11:39:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Nccds2QfxdwEbRE3n8zyccPUL5MosHk5btEHY7l/fFk=;
 b=A0xUzkgPDvdoD4f1Z2qDuyQMgUO8Xd9C3gNR49T6wFvCMH0V2YX0vmF5PeQzyeHLcvd7
 lmAVzgjfk+V/gFa7WWa3yYVhJ33vWFj3SsmPmNgZMTM8rlVNDXxlcFkBDCdqIn3XSvF/
 yMnn5zyjYwAAWMEX4taVpnwK8QHNlbzMh2dwdDqLf9kmMDwJ2LKdKoSOiYGXDmodT1Qj
 ycOkQ9K9gTxhbTsfC0MFcbtqKMj2S9MJ9Xzd6w3DI+dd7QxYxQwbYKfL+DJhbXWQGQZ6
 RbYVg1CBOAkwxJRuQqZ3S6qnF2+g7hHHRZ2gkjwpN/G3ZjNRhImdAjtNpV+d1OixCTES BA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rda1f0ygd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 11:39:52 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35NB6j6c025494
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 11:39:52 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rda1f0yfx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Jun 2023 11:39:51 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35N0pc7f027777;
 Fri, 23 Jun 2023 11:39:49 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3r94f5c468-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Jun 2023 11:39:49 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35NBdl1d8782500
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 Jun 2023 11:39:47 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3B7E820049;
 Fri, 23 Jun 2023 11:39:47 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E814A20043;
 Fri, 23 Jun 2023 11:39:46 +0000 (GMT)
Received: from li-7e0de7cc-2d9d-11b2-a85c-de26c016e5ad.ibm.com (unknown
 [9.171.77.153]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 23 Jun 2023 11:39:46 +0000 (GMT)
Message-ID: <e1603f7667334c649f7109eaebb759162bfb55dc.camel@linux.ibm.com>
Subject: Re: [PATCH v2] git-submodule.sh: allow running in validate mode
 without previous update
From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com
Date: Fri, 23 Jun 2023 13:39:46 +0200
In-Reply-To: <20230622095254.52398-1-pbonzini@redhat.com>
References: <20230622095254.52398-1-pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NAfU1hroPt6CPrZwn4jknt_O5Xje4plR
X-Proofpoint-ORIG-GUID: gUmcabiFAHAn1VFYtHBKj-_m-BsmA2bt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_06,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 mlxlogscore=931 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306230105
Received-SPF: pass client-ip=148.163.156.1; envelope-from=nsg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, 2023-06-22 at 11:52 +0200, Paolo Bonzini wrote:
> The call to git-submodule.sh done in configure may happen without a
> previous checkout of the roms/SLOF submodule, or even without a
> previous run of the script.
>=20
> So, handle creating a .git-submodule-status file even in validate
> mode.  If git is absent, ensure that all passed directories exists
> (because you should be in a fresh untar and will not have stale
> arguments to git-submodule.sh) but do no other checks.  If git
> is present, ensure that .git-submodule-status contains an entry
> for all submodules passed on the command line.
>=20
> With this change, "ignore" mode is not needed anymore.
>=20
> Reported-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Fixes: b11f9bd96f4 ("configure: move SLOF submodule handling to pc-bios/s=
390-ccw", 2023-06-06)

Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Tested-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  configure                |  2 +-
>  scripts/git-submodule.sh | 73 ++++++++++++++++++++++------------------
>  2 files changed, 42 insertions(+), 33 deletions(-)

[...]

>  case "$command" in
>  status|validate)
> -    test -f "$substat" || validate_error "$command"
> -    test -z "$maybe_modules" && exit 0
>      for module in $modules; do
> -        check_updated $module || validate_error "$command"
> +        if is_git; then
> +            check_updated $module || validate_error "$command"
> +        elif ! (set xyz "$module"/* && test -e "$2"); then

You could also do set -- "$module"/* and use $1, not that it matters.

> +            # The directory does not exist or it contains no files
> +            echo "$0: sources not available for $module and $no_git_erro=
r"
> +            validate_error "$command"
> +        fi
>      done
> -    exit 0
>      ;;
> +
>  update)
> -    test -e $substat || touch $substat
> -    test -z "$maybe_modules" && exit 0
> +    is_git || {
> +        echo "$0: unexpectedly called with submodules but $no_git_error"
> +        exit 1
> +    }
> =20
>      $GIT submodule update --init $modules 1>/dev/null
>      test $? -ne 0 && update_error "failed to update modules"


